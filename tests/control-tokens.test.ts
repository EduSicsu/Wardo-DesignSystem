// @vitest-environment node
import { describe, expect, it } from 'vitest';
import { readFileSync } from 'node:fs';
// @ts-expect-error build helper is intentionally plain JavaScript
import { generateControlTokens } from '../scripts/control-tokens.mjs';

const tokens = JSON.parse(readFileSync(new URL('../tokens/controls.figma.json', import.meta.url), 'utf8'));
describe('cross-platform control token source', () => {
  it('rejects non-finite or incomplete metric profiles before generating native code', () => {
    const invalid = structuredClone(tokens);
    invalid[0].modes.M = Infinity;
    expect(() => generateControlTokens(invalid)).toThrow('Invalid control token');
    const missing = structuredClone(tokens).filter((token: {name: string}) => token.name !== 'control/type/label/line-height');
    expect(() => generateControlTokens(missing)).toThrow('Invalid control token');
  });
  it('generates all eight profiles and preserves scalable native typography units', () => {
    const generated: [string, string][] = generateControlTokens(tokens);
    const swift = generated.find(([path]) => path.endsWith('.swift'))![1];
    const kotlin = generated.find(([path]) => path.endsWith('.kt'))![1];
    expect((swift.split('public struct')[0].match(/case .* = "/g) ?? []).length).toBe(8);
    expect(swift).toContain('case xxl = "2XL"');
    expect(swift).toContain('self.minHeight = 48');
    expect(kotlin).toContain('48.dp, 8.dp, 16.sp,');
  });
});
