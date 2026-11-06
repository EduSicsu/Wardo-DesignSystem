import { readFile, writeFile } from 'node:fs/promises';
const colors = JSON.parse(await readFile(new URL('../tokens/colors.figma.json', import.meta.url), 'utf8'));
for(const token of colors.tokens) for(const [mode,value] of Object.entries(token.modes)) if(!/^#[0-9a-f]{6}([0-9a-f]{2})?$/i.test(value)) throw Error(`Invalid color: ${token.name}, ${mode}`);
const controls = JSON.parse(await readFile(new URL('../tokens/controls.figma.json', import.meta.url), 'utf8'));
export const slug = s => s.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
function rgb(hex){return [1,3,5].map(i=>parseInt(hex.slice(i,i+2),16)/255);}
function luminance(hex){return rgb(hex).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4).reduce((s,v,i)=>s+v*[.2126,.7152,.0722][i],0);}
function contrast(a,b){const x=luminance(a),y=luminance(b);return (Math.max(x,y)+.05)/(Math.min(x,y)+.05);}
function readable(preferred,backgrounds){if(backgrounds.every(bg=>contrast(preferred,bg)>=4.5))return preferred;return ['#161615','#fffdfc','#000000','#ffffff'].sort((a,b)=>Math.min(...backgrounds.map(bg=>contrast(b,bg)))-Math.min(...backgrounds.map(bg=>contrast(a,bg))))[0];}
let css = '/* Generated from Figma. Edit tokens/*.figma.json, then npm run tokens. */\n';
for (const mode of colors.modes) {
  css += `${mode === 'Wardo Light' ? ':root, ' : ''}[data-wardo-theme="${slug(mode)}"] {\n`;
  for (const t of colors.tokens) css += `  --${slug(t.name.replace('color/semantic/', 'color/'))}: ${t.modes[mode]};\n`;
  const color = name => colors.tokens.find(t=>t.name===`color/semantic/${name}`).modes[mode];
  // Web readability aliases preserve the exact Figma snapshot and adapt only rendered text.
  const surfaces=[color('background/default'),color('background/raised')];
  css += `  --color-action-transparent-foreground: ${readable(color('text/brand'),surfaces)};\n`;
  for(const tone of ['success','warning','error','info']) {
    const fg=color(`feedback/${tone}-foreground`),bg=color(`feedback/${tone}-background`);
    css += `  --color-feedback-${tone}-readable: ${readable(fg,[bg])};\n`;
    css += `  --color-feedback-${tone}-text: ${readable(fg,surfaces)};\n`;
  }
  css += `  color-scheme: ${mode.endsWith('Dark') ? 'dark' : 'light'};\n}\n`;
}
const sizes = controls.find(t=>t.name==='control/size/min-height');
for (const size of Object.keys(sizes.modes)) {
  css += `${size === 'M' ? ':root, ' : ''}[data-wardo-size="${size}"] {\n`;
  for(const token of controls.filter(t=>Object.hasOwn(t.modes,size))) css+=`  --${slug(token.name)}: ${Number((token.modes[size]/16).toFixed(6))}rem;\n`;
  css += '}\n';
}
css += ':root { --control-content-padding-x: 1.5rem; --control-content-padding-y: .75rem; --control-theme-radius: .5rem; --font-heading: "Geologica Variable", "Geologica", system-ui, sans-serif; --font-body: "Source Serif 4 Variable", "Source Serif 4", Georgia, serif; }\n';
css += '[data-wardo-condition="serious"] { --control-theme-radius: .25rem; }\n[data-wardo-condition="chonky"] { --control-theme-radius: 16rem; }\n';
await writeFile(new URL('../src/styles/tokens.css', import.meta.url), css);
const base=await readFile(new URL('../src/styles/components.css',import.meta.url),'utf8');
await writeFile(new URL('../src/styles/styles.css', import.meta.url), css+'\n'+base);
console.log(`Generated ${colors.tokens.length} color tokens × ${colors.modes.length} themes and ${Object.keys(sizes.modes).length} sizes.`);
