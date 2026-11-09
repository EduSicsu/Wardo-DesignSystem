import { readFile, writeFile, mkdir } from 'node:fs/promises';
const root = new URL('../', import.meta.url);
const read = async path => JSON.parse(await readFile(new URL(path, root), 'utf8'));
const inventory = await read('figma/published-classification.json');
let removedArchiveIds=new Set();
try { removedArchiveIds=new Set((await read('coverage/figma-archive-cleanup.json')).deletedIds??[]); } catch(error) { if(error.code!=='ENOENT')throw error; }
const original = await read('figma/mappings.json');
const saved = [...original.components, ...(original.icons ?? []), ...(await read('figma/expanded-mappings.json')).components, ...(await read('figma/web-internals-mappings.json')).components];
const native = (await read('figma/native-mappings.json')).components;
let reviewed = {};
try { reviewed = await read('coverage/implementations.json'); } catch (error) { if(error.code !== 'ENOENT') throw error; }
const contexts = new Map();
for (const name of ['Button','ActionChip','Accordion','AccordionGroup','TextField','TextArea','PasswordField','SearchField','NumberField','Select','Checkbox','ComboBox','Tabs','Dialog','Banner','ContentCard','Divider','Link','MetadataTag','MenuButton']) {
 const data = await read(`figma/context/${name}.json`);
 for (const item of Array.isArray(data) ? data : [data]) if(item.nodeId) contexts.set(item.nodeId, item.properties ?? {});
}
const referenceReasons = {
 archived: 'Retired design retained for historical reference; excluded from the supported runtime library.',
 documentation: 'Design-system documentation or organization asset; reference material rather than an application control.',
 'device-reference': 'Device or operating-system reference; use the platform environment rather than recreating system chrome.'
};
const samplePreviews = await read('coverage/previews.json');
const entries = inventory.entries.filter(item=>!removedArchiveIds.has(item.id)).map(item => {
 const connected = saved.find(map => map.nodeId === item.id);
 const candidate = connected ?? native.find(map => map.nodeId === item.id);
 const override = reviewed[item.id] ?? {};
 const category = item.id === '1531:22852' ? 'archived' : item.category;
 const active = category === 'runtime-candidate' || category === 'example-composition';
 const implementation = override.implementation ?? (candidate ? {status:'source-available', framework: connected ? 'React' : 'SwiftUI', platforms: connected ? ['web'] : (candidate.designName?.includes('SF Symbols') ? ['iOS','iPadOS','visionOS','macOS'] : ['iOS','iPadOS']), source:candidate.source, symbol:candidate.componentName, example:null} : {status: active ? 'pending' : 'not-applicable'});
 return {
  id:`wardo-${item.id.replace(':','-')}`, nodeId:item.id, name:item.name, page:item.page.trim(), category,
  figmaUrl:`https://www.figma.com/design/${original.fileKey}/Wardo-DS?node-id=${item.id.replace(':','-')}`,
  ...(!active ? {reason:referenceReasons[category], reference:{kind:category, url:`https://www.figma.com/design/${original.fileKey}/Wardo-DS?node-id=${item.id.replace(':','-')}`}} : {}),
  implementation,
  alternatives:override.alternatives ?? [],
  properties: override.properties ?? {status:contexts.has(item.id) ? 'design-properties-recorded' : active ? 'pending-review' : 'not-applicable', definitions:contexts.get(item.id) ?? {}, mappings:[]},
  validation:override.validation ?? {status:active ? 'pending' : 'not-applicable', evidence:[]},
  connection:{status:connected ? 'source-connection-saved' : active ? 'not-connected' : 'not-applicable', framework:connected ? 'React' : null},
  previews:override.previews ?? []
 };
});
await mkdir(new URL('coverage/', root), {recursive:true});
await writeFile(new URL('coverage/registry.json', root), JSON.stringify({schemaVersion:1,sourceRef:'codex/wardo-cross-platform-coverage',fileKey:original.fileKey,inventorySource:'figma/published-classification.json',samplePreviews,entries},null,2)+'\n');
console.log(`Built ${entries.length} coverage records; ${entries.filter(e=>e.connection.status==='source-connection-saved').length} saved Figma source links.`);
