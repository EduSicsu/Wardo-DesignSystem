import {readFile,access} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
const registries=await Promise.all(['figma/mappings.json','figma/expanded-mappings.json','figma/web-internals-mappings.json'].map(async path=>JSON.parse(await readFile(path,'utf8'))));
const ids=new Set();
for(const entry of registries.flatMap(registry=>[...registry.components,...(registry.icons??[])])){
 if(ids.has(entry.nodeId))throw Error(`Duplicate node: ${entry.nodeId}`);ids.add(entry.nodeId);
 await access(entry.source);
 const source=await readFile(entry.source,'utf8');if(!new RegExp(`export (?:function|const) ${entry.componentName}\\b`).test(source))throw Error(`Missing export: ${entry.componentName}`);
 if(entry.templateFile){const template=await readFile(entry.templateFile,'utf8');if(!template.includes('figma.code`')||template.includes('figma.connect(')||entry.templateFile.endsWith('.tsx'))throw Error('Expected parserless .figma.ts template');}
}
execFileSync('node_modules/.bin/tsc',['-p','figma/tsconfig.json'],{stdio:'inherit'});
console.log(`Validated ${ids.size} Figma-to-code source mappings.`);
