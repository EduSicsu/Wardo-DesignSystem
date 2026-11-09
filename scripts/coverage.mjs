import { readFile } from 'node:fs/promises';
import { createHash } from 'node:crypto';
import { pathToFileURL } from 'node:url';
const root = new URL('../', import.meta.url);
export const loadRegistry = async () => JSON.parse(await readFile(new URL('coverage/registry.json',root),'utf8'));
export function summarize(entries) {
 const active=entries.filter(e=>['runtime-candidate','example-composition'].includes(e.category));
 return {total:entries.length,active:active.length,reference:entries.length-active.length,sourceAvailable:active.filter(e=>e.implementation.source).length,validated:active.filter(e=>e.validation.status==='verified').length,figmaConnected:entries.filter(e=>e.connection.status==='source-connection-saved').length,unresolved:active.filter(e=>e.implementation.status!=='implemented'||e.validation.status!=='verified'||e.properties.status!=='mapped').length};
}
export function lookup(entries,query) {
 let node=query;
 try { const parsed=new URL(query); node=parsed.searchParams.get('node-id') ?? query; } catch {}
 node=node.replace(/^(\d+)-(\d+)$/,'$1:$2');
 return entries.filter(e=>e.id===query||e.nodeId===node||e.name.toLowerCase()===query.toLowerCase()||[e.implementation,...(e.alternatives??[])].some(binding=>binding.symbol===query));
}
export async function checkRegistry(registry,{complete=false}={}) {
 const failures=[];
 const safePath=value=>typeof value==='string'&&value.length>0&&!value.startsWith('/')&&!value.includes('\\')&&!/[?#%]/.test(value)&&!value.split('/').some(part=>part==='..'||part==='')&&!/^[a-z]+:/i.test(value);
 const sourceCheck=async(binding,id)=>{
  if(!safePath(binding.source)){failures.push(`${id}: source must be repository-relative`);return;}
  if(!/^[A-Za-z_][A-Za-z0-9_]*$/.test(binding.symbol??'')){failures.push(`${id}: invalid source symbol`);return;}
  try { const text=await readFile(new URL(binding.source,root),'utf8');if(!new RegExp(`\\b${binding.symbol}\\b`).test(text))failures.push(`${id}: source symbol missing`); }
  catch { failures.push(`${id}: missing source ${binding.source}`); }
 };
 const inventory=JSON.parse(await readFile(new URL(registry.inventorySource,root),'utf8'));
 const expected=new Set(inventory.entries.map(e=>e.id)); const seen=new Set();
 for(const entry of registry.entries) {
  if(seen.has(entry.nodeId)) failures.push(`Duplicate node ${entry.nodeId}`);
  seen.add(entry.nodeId);
  if(!expected.has(entry.nodeId)) failures.push(`Unknown node ${entry.nodeId}`);
  const active=['runtime-candidate','example-composition'].includes(entry.category);
  if(!active && (!entry.reason||!entry.reference?.url)) failures.push(`${entry.id}: missing reference disposition`);
  if(entry.id!==`wardo-${entry.nodeId.replace(':','-')}`)failures.push(`${entry.id}: unstable component identifier`);
  if(entry.implementation.source) await sourceCheck(entry.implementation,entry.id);
  for(const binding of entry.alternatives??[]) await sourceCheck(binding,entry.id);
  if(entry.properties.status==='mapped') {
   const mapped=new Set(entry.properties.mappings.map(mapping=>mapping.property));
   for(const key of Object.keys(entry.properties.definitions))if(!mapped.has(key))failures.push(`${entry.id}: missing property mapping ${key}`);
   for(const key of mapped)if(!Object.hasOwn(entry.properties.definitions,key))failures.push(`${entry.id}: mapping for unknown property ${key}`);
  }
  if(entry.implementation.status==='implemented'&&(!entry.implementation.example||entry.implementation.gaps?.length))failures.push(`${entry.id}: implemented without a usage example or with unresolved gaps`);
  if(complete&&active) for(const binding of entry.alternatives??[]) {
   if(binding.status!=='implemented'||binding.validation?.status!=='verified'||binding.properties?.status!=='mapped')failures.push(`${entry.id}: incomplete alternative ${binding.framework??binding.symbol}`);
  }
  if(entry.validation.status==='verified') {
   if(!entry.validation.evidence.length || !entry.implementation.source || !entry.implementation.example || entry.properties.status!=='mapped') failures.push(`${entry.id}: verified without implementation, example, properties, and evidence`);
   if(entry.implementation.gaps?.length)failures.push(`${entry.id}: verified with unresolved implementation gaps`);
   if(!entry.properties.mappings.length&&Object.keys(entry.properties.definitions).length)failures.push(`${entry.id}: verified with unmapped design properties`);
  }
  for(const evidence of entry.validation.evidence) {
    if(!safePath(evidence)){failures.push(`${entry.id}: evidence must be repository-relative`);continue;}
    try { const bytes=await readFile(new URL(evidence,root));if(!bytes.length)failures.push(`${entry.id}: empty evidence ${evidence}`); }
    catch { failures.push(`${entry.id}: missing evidence ${evidence}`); }
  }
  if(complete&&active&&(entry.implementation.status!=='implemented'||entry.validation.status!=='verified'||entry.properties.status!=='mapped')) failures.push(`${entry.id}: incomplete ${entry.name}`);
 }
 for(const node of expected) if(!seen.has(node)) failures.push(`Missing node ${node}`);
 try {
  const assets=JSON.parse(await readFile(new URL('coverage/example-assets.json',root),'utf8'));
  for(const asset of assets.assets??assets) {
   const path=asset.file??asset.path;
   if(!safePath(path)){failures.push(`Unsafe asset path ${path}`);continue;}
   try { const bytes=await readFile(new URL(path,root));if(!bytes.length||asset.sha256&&createHash('sha256').update(bytes).digest('hex')!==asset.sha256)failures.push(`Missing or changed asset ${path}`); }
   catch {failures.push(`Missing asset ${path}`);}
  }
 } catch(error) { failures.push(`Invalid example asset manifest: ${error.message}`); }
 try {
  const assets=JSON.parse(await readFile(new URL('coverage/native-slider-assets.json',root),'utf8'));
  for(const asset of assets.assets) for(const [path,hash] of [[asset.source,asset.sourceSha256],[asset.render,asset.renderSha256],[asset.native,asset.renderSha256]]) {
   if(!safePath(path)||!/^[a-f0-9]{64}$/.test(hash??'')){failures.push('Invalid native slider asset reference');continue;}
   try { const bytes=await readFile(new URL(path,root));if(!bytes.length||createHash('sha256').update(bytes).digest('hex')!==hash)failures.push(`Missing or changed native slider asset ${path}`); }
   catch {failures.push(`Missing native slider asset ${path}`);}
  }
 } catch(error) {failures.push(`Invalid native slider asset manifest: ${error.message}`);}
 try {
  const manifest=JSON.parse(await readFile(new URL('coverage/native-toolbar-assets.json',root),'utf8'));
  if(!safePath(manifest.rendererSource))throw new Error('Unsafe renderer source path');
  const renderer=await readFile(new URL(manifest.rendererSource,root),'utf8');
  for(const asset of manifest.assets) {
   for(const [path,hash] of [[asset.source,asset.sourceSha256],[asset.native,asset.nativeSha256]]) {
    if(!safePath(path)||!/^[a-f0-9]{64}$/.test(hash??'')){failures.push('Invalid Android toolbar asset reference');continue;}
    try { const bytes=await readFile(new URL(path,root));if(!bytes.length||createHash('sha256').update(bytes).digest('hex')!==hash)failures.push(`Missing or changed Android toolbar asset ${path}`); }
    catch {failures.push(`Missing Android toolbar asset ${path}`);}
   }
   if(!renderer.includes(`R.drawable.${asset.resource}`))failures.push(`Unused Android toolbar resource ${asset.resource}`);
   const svg=await readFile(new URL(asset.source,root),'utf8');
   const vector=await readFile(new URL(asset.native,root),'utf8');
   const svgRoot=svg.match(/<svg\b[^>]*>/)?.[0]??'';
   const vectorRoot=vector.match(/<vector\b[^>]*>/)?.[0]??'';
   if(!/\bwidth="24"/.test(svgRoot)||!/\bheight="24"/.test(svgRoot)||!vectorRoot.includes('android:width="24dp"')||!vectorRoot.includes('android:height="24dp"'))failures.push(`Changed Android toolbar root geometry ${asset.resource}`);
  }
 } catch(error) {failures.push(`Invalid Android toolbar asset manifest: ${error.message}`);}
 try {
  const manifest=JSON.parse(await readFile(new URL('coverage/navigation-artwork-assets.json',root),'utf8'));
  const sources={};for(const [platform,path] of Object.entries(manifest.rendererSources)){if(!safePath(path))throw new Error('Unsafe navigation renderer path');sources[platform]=await readFile(new URL(path,root),'utf8');}
  for(const asset of manifest.assets) {
   for(const [path,hash] of [[asset.source,asset.sourceSha256],[asset.apple,asset.sourceSha256],[asset.android,asset.androidSha256]]) {
    if(!safePath(path)||!/^[a-f0-9]{64}$/.test(hash??'')){failures.push('Invalid navigation artwork reference');continue;}
    try {const bytes=await readFile(new URL(path,root));if(!bytes.length||createHash('sha256').update(bytes).digest('hex')!==hash)failures.push(`Missing or changed navigation artwork ${path}`);}
    catch {failures.push(`Missing navigation artwork ${path}`);}
   }
   if(!safePath(asset.appleContents))throw new Error('Unsafe image-set metadata path');
   const contents=JSON.parse(await readFile(new URL(asset.appleContents,root),'utf8'));
   if(contents.images?.[0]?.filename!==asset.apple.split('/').at(-1)||contents.properties?.['preserves-vector-representation']!==true||contents.properties?.['template-rendering-intent']!=='template')failures.push(`Invalid native image-set configuration ${asset.assetName}`);
   if(!sources.apple.includes(`"${asset.assetName}"`)||!sources.android.includes(`R.drawable.${asset.resource}`)||!sources.web.includes(`"${asset.name}":`))failures.push(`Unused navigation artwork ${asset.name}`);
  }
 } catch(error) {failures.push(`Invalid navigation artwork manifest: ${error.message}`);}
 for(const preview of [...(registry.samplePreviews??[]),...registry.entries.flatMap(entry=>entry.previews??[])]) {
  if(!safePath(preview.path)){failures.push(`Unsafe preview path ${preview.path}`);continue;}
  try { const bytes=await readFile(new URL(preview.path,root));if(!bytes.length)failures.push(`Empty preview ${preview.path}`);else if(bytes.length>24&&bytes.subarray(1,4).toString()==='PNG'&&(bytes.readUInt32BE(16)<2||bytes.readUInt32BE(20)<2))failures.push(`Invalid placeholder preview ${preview.path}`); }
  catch {failures.push(`Missing preview ${preview.path}`);}
 }
 if(registry.schemaVersion!==1) failures.push('Unsupported registry version');
 return failures;
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href) {
 const registry=await loadRegistry(); const [command='summary',...args]=process.argv.slice(2);
 if(command==='lookup') {
  const index=args.indexOf('--platform');const platform=index<0?null:args[index+1];
  if(index>=0&&!platform){console.error('--platform requires a platform name');process.exit(2);}
  const query=(index<0?args:args.filter((_,i)=>i!==index&&i!==index+1)).join(' ');
  const matches=lookup(registry.entries,query).flatMap(entry=>{
   if(!platform)return [entry];
   const candidates=[entry.implementation,...(entry.alternatives??[])].filter(binding=>binding.platforms?.some(value=>value.toLowerCase()===platform.toLowerCase()));
   return candidates.map(implementation=>({...entry,implementation,alternatives:[entry.implementation,...(entry.alternatives??[])].filter(binding=>binding!==implementation)}));
  });
  console.log(JSON.stringify(matches,null,2));if(!matches.length)process.exitCode=1;
 }
 else if(command==='check') { const failures=await checkRegistry(registry,{complete:args.includes('--complete')}); console.log(JSON.stringify(summarize(registry.entries),null,2)); if(failures.length) {console.error(failures.join('\n'));process.exitCode=1;} }
 else if(command==='pending') console.log(JSON.stringify(registry.entries.filter(e=>['runtime-candidate','example-composition'].includes(e.category)&&(e.validation.status!=='verified'||e.properties.status!=='mapped')),null,2));
 else if(command==='summary') console.log(JSON.stringify(summarize(registry.entries),null,2));
 else {console.error('Use summary, lookup <node/id/name/URL>, pending, or check [--complete]');process.exitCode=2;}
}
