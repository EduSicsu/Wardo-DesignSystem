#!/usr/bin/env node
import { execFileSync } from 'node:child_process';
import { createHash } from 'node:crypto';
import { existsSync, readFileSync, writeFileSync } from 'node:fs';

const [device, output] = process.argv.slice(2);
if (!device || !output) {
  console.error('Usage: AXE_BIN=/path/to/axe node check-alert-keyboard.mjs SIMULATOR_ID OUTPUT_JSON');
  process.exit(2);
}
const axe = process.env.AXE_BIN ?? 'axe';
const env = { ...process.env, DEVELOPER_DIR: process.env.DEVELOPER_DIR ?? '/Applications/Xcode.app/Contents/Developer' };
const options = { encoding: 'utf8', env, maxBuffer: 8 * 1024 * 1024 };
const invoke = (file, args) => execFileSync(file, args, options);
const action = args => invoke(axe, [...args, '--udid', device]);
const flatten = value => Array.isArray(value) ? value.flatMap(flatten)
  : value && typeof value === 'object' ? [value, ...flatten(value.children ?? [])] : [];
const snapshot = () => flatten(JSON.parse(action(['describe-ui'])));
const hasAlert = nodes => nodes.some(node => node.type === 'Sheet' && node.AXLabel === 'Edit event');
async function waitFor(predicate) {
  const deadline = Date.now() + 15000;
  do {
    const nodes = snapshot();
    if (predicate(nodes)) return nodes;
    await new Promise(resolve => setTimeout(resolve, 150));
  } while (Date.now() < deadline);
  throw new Error('Expected native alert state was not reached');
}
async function launch() {
  invoke('xcrun', ['simctl', 'launch', '--terminate-running-process', device, 'com.wardo.catalogue', '--wardo-native-presentations']);
  await waitFor(nodes => nodes.some(node => node.type === 'Button' && node.AXLabel === 'Present native alert'));
}
async function openAlert() {
  const nodes = snapshot();
  if (!nodes.some(node => node.type === 'Button' && node.AXLabel === 'Present native alert')) throw new Error('Wrong sample screen');
  action(['tap', '--label', 'Present native alert', '--element-type', 'Button']);
  return waitFor(hasAlert);
}
async function expectStatus(expected) {
  await waitFor(nodes => !hasAlert(nodes));
  for (let attempt = 0; attempt < 5; attempt++) {
    const nodes = snapshot();
    const status = nodes.find(node => node.AXUniqueId === 'native-presentation-status');
    if (status?.AXLabel === expected) return status.AXLabel;
    if (!status) {
      const frame = nodes.find(node => node.type === 'Application')?.frame;
      if (!frame) throw new Error('Missing sample viewport');
      const x = frame.x + frame.width * 0.5;
      action(['swipe', '--start-x', String(x), '--end-x', String(x),
        '--start-y', String(frame.y + frame.height * 0.8), '--end-y', String(frame.y + frame.height * 0.3), '--duration', '0.35']);
    }
  }
  throw new Error(`Expected application callback: ${expected}`);
}

// Real HID events exercise UIKit's keyboard-command path. XCTest's typeKey
// named-key injection on this simulator did not dispatch Return/Escape to it.
const axeVersion = invoke(axe, ['--version']).trim();
await launch();
const open = await openAlert();
const field = open.find(node => node.type === 'TextField' && (node.AXLabel === 'Event name' || node.AXValue === 'Event name'));
if (!field) throw new Error('Missing native event-name field');
action(['tap', field.AXLabel ? '--label' : '--value', 'Event name', '--element-type', 'TextField']);
action(['type', 'Hardware event']);
action(['key', '43']); // USB HID Tab
// Synthetic data only; no sharing or external action occurs.
action(['type', '2468']);
const enteredFields = snapshot().filter(node => node.type === 'TextField');
const enteredName = enteredFields.find(node => node.AXValue === 'Hardware event');
const enteredCode = enteredFields.find(node => node !== enteredName);
if (!enteredName || String(enteredCode?.AXValue ?? '').length !== 4) throw new Error('Tab did not preserve both native field values');
action(['key', '40']); // USB HID Return
const saved = await expectStatus('Saved: Hardware event');
await launch();
await openAlert();
action(['key', '41']); // USB HID Escape
const cancelled = await expectStatus('Alert cancelled');
const app = invoke('xcrun', ['simctl', 'get_app_container', device, 'com.wardo.catalogue', 'app']).trim();
const image = existsSync(`${app}/WardoCatalogue.debug.dylib`) ? `${app}/WardoCatalogue.debug.dylib` : `${app}/WardoCatalogue`;
const hash = data => createHash('sha256').update(data).digest('hex');
const sourcePaths = ['native/apple/Sources/WardoDesignSystem/NativePresentation.swift', 'native/apple/Sample/CatalogueApp.swift'];
const sourceHashes = Object.fromEntries(sourcePaths.map(path => [path, hash(readFileSync(new URL(`../../../../${path}`, import.meta.url)))]));
const evidence = {
  date: new Date().toISOString(), format: 'wardo-native-alert-hid-v1', device, axeVersion,
  component: 'NativeAlertModifier', sample: '--wardo-native-presentations',
  checks: [{ name: 'Tab retains the name and enters four characters in the secure field', result: 'passed', secureValueLength: 4 },
    { name: 'Return, native dismissal and app save callback', result: 'passed', observed: saved },
    { name: 'Escape, native dismissal and app cancellation callback', result: 'passed', observed: cancelled }],
  appImageSha256: hash(readFileSync(image)), sourceHashes,
  scope: 'Simulator USB-HID keyboard path only; no physical device or hardware keyboard was used. Other variants, accessibility and appearance have separate evidence.'
};
writeFileSync(output, `${JSON.stringify(evidence, null, 2)}\n`);
console.log(JSON.stringify({ result: 'passed', device, checks: evidence.checks.length, output }));
