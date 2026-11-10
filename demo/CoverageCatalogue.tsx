import { useMemo, useState } from 'react';
import registryData from '../coverage/registry.json';
interface Binding {validation?:{status:string;evidence:string[]}; properties?:{status:string}; status:string; source?:string; symbol?:string; platforms?:string[]; example?:string|null; gaps?:string[]; framework?:string}
interface CatalogueEntry { id:string; nodeId:string; name:string; page:string; category:string; scope:{status:string;kind:string;reason?:string}; figmaUrl:string; reason?:string; implementation:Binding; alternatives:Binding[]; properties:{status:string; definitions:unknown; mappings:unknown[]}; validation:{status:string; evidence:string[]}; connection:{status:string;framework?:string|null;cleanup?:string}; previews:{path:string;alt?:string;platform?:string}[]; }
interface NativePreview {path:string;platform:string;alt:string;caption:string}
const registry: {entries:CatalogueEntry[];samplePreviews:NativePreview[]}=registryData;
import { SearchField, Select, Button } from '../src';
import './coverage.css';
const previewAssets=import.meta.glob<string>('../coverage/previews/**/*.{png,jpg}',{eager:true,query:'?url&no-inline',import:'default'});
const PAGE_SIZE=30;
const bindingsFor=(entry:CatalogueEntry,platform:string)=>[entry.implementation,...entry.alternatives].filter(binding=>platform==='all'||binding.platforms?.includes(platform));
const isVerified=(entry:CatalogueEntry,binding:Binding)=>binding===entry.implementation?entry.validation.status==='verified':binding.validation?.status==='verified';
export function CoverageCatalogue() {
 const [query,setQuery]=useState('');
 const [platform,setPlatform]=useState('all');
 const [state,setState]=useState('apps');
 const [page,setPage]=useState(0);
 const entries=useMemo(()=>registry.entries.filter(entry=>{
  const bindings=bindingsFor(entry,platform);
  return `${entry.name} ${entry.nodeId} ${entry.id} ${bindings.map(binding=>binding.symbol??'').join(' ')}`.toLowerCase().includes(query.toLowerCase())
   && bindings.length>0
   && (state==='all'||(state==='apps'?entry.scope.status==='included':state==='references'?entry.scope.status!=='included':state==='validated'?entry.scope.status==='included'&&bindings.every(binding=>isVerified(entry,binding)):state==='connected'?entry.scope.status==='included'&&entry.connection.status==='source-connection-saved':entry.scope.status==='included'&&bindings.some(binding=>!isVerified(entry,binding))));
 }),[query,platform,state]);
 const active=registry.entries.filter(e=>e.scope.status==='included');
 const connected=active.filter(e=>e.connection.status==='source-connection-saved').length;
 const validated=active.filter(e=>e.validation.status==='verified').length;
 const lastPage=Math.max(0,Math.ceil(entries.length/PAGE_SIZE)-1);
 const current=Math.min(page,lastPage);
 return <main className="coverage-catalogue" data-wardo-theme="wardo-light">
  <a href="/library">← Component gallery</a>
  <h1>Wardo coverage catalogue</h1>
  <p>Find the implementation for a design across web, Apple, and Android. Only reusable app components are implementation targets. Documentation, showcase examples, device references, and Apple Watch are excluded. Source availability, validation, and Figma connections are tracked separately.</p>
  <dl className="coverage-metrics"><div><dt>Excluded reference records</dt><dd>{registry.entries.length-active.length}</dd></div><div><dt>App components</dt><dd>{active.length}</dd></div><div><dt>Validated active entries</dt><dd>{validated} / {active.length}</dd></div><div><dt>App source links</dt><dd>{connected} / {active.length}</dd></div></dl>
  <details className="coverage-native-previews"><summary>Native sample previews</summary><p>Running sample applications. Per-entry verification remains recorded separately below.</p><div>{registry.samplePreviews.map(preview=><figure key={preview.path}><a href={previewAssets[`../${preview.path}`]}><img loading="lazy" src={previewAssets[`../${preview.path}`]} alt={preview.alt}/></a><figcaption>{preview.caption}</figcaption></figure>)}</div></details>
  <div className="coverage-filters"><SearchField label="Find a design or component" placeholder="Name, source symbol, or node ID" value={query} onChange={event=>{setQuery(event.target.value);setPage(0);}}/><Select label="Platform" value={platform} onChange={event=>{setPlatform(event.target.value);setPage(0);}}>{['all','web','iOS','iPadOS','visionOS','Android','Android XR','macOS'].map(p=><option key={p} value={p}>{p==='all'?'All platforms':p}</option>)}</Select><Select label="Coverage" value={state} onChange={event=>{setState(event.target.value);setPage(0);}}><option value="apps">App components</option><option value="all">All catalogue records</option><option value="pending">Needs validation</option><option value="validated">Validated</option><option value="connected">Connected in Figma</option><option value="references">Reference entries</option></Select></div>
  <p role="status">{entries.length} matching {entries.length===1?'entry':'entries'}. Page {current+1} of {lastPage+1}.</p>
  <div className="coverage-records">{entries.slice(current*PAGE_SIZE,(current+1)*PAGE_SIZE).map(entry=>{
   const bindings=bindingsFor(entry,platform);
   const implementation=bindings[0];
   const validation=implementation===entry.implementation?entry.validation:implementation.validation;
   const separateConnection=entry.connection.status==='source-connection-saved'&&implementation.framework!==entry.connection.framework;
   return <article key={entry.id} id={entry.id}><div className="coverage-record-heading"><h2>{entry.name}</h2><a href={entry.figmaUrl}>Open in Figma ↗</a></div><p>{entry.page} · {entry.nodeId} · {entry.category.replaceAll('-',' ')}</p>
    {'reason' in entry&&<p>{entry.reason}</p>}
    <dl className="coverage-states"><div><dt>Implementation</dt><dd>{implementation.status.replaceAll('-',' ')}</dd></div><div><dt>Validation</dt><dd>{validation?.status??'pending'}</dd></div><div><dt>Figma</dt><dd>{separateConnection?'not connected':entry.connection.status.replaceAll('-',' ')}</dd></div></dl>
    {separateConnection&&<p>A {entry.connection.framework} source connection is saved separately for this design.</p>}
    {bindings.filter(binding=>binding.source).map(binding=><section key={`${binding.source}:${binding.symbol}`} aria-label={`${binding.framework??''} implementation`}>
     <p><a href={`https://github.com/EduSicsu/Wardo-DesignSystem/blob/${import.meta.env.VITE_WARDO_SOURCE_REF ?? registryData.sourceRef ?? 'main'}/${binding.source}`}>{binding.symbol??binding.source}</a> · {binding.platforms?.join(', ')}</p>
     <p>Implementation: {binding.status.replaceAll('-',' ')} · Validation: {isVerified(entry,binding)?'verified':'pending'}</p>
     {binding.example&&<pre><code>{binding.example}</code></pre>}
     {!!binding.gaps?.length&&<><p>Outstanding review:</p><ul>{binding.gaps.map(gap=><li key={gap}>{gap}</li>)}</ul></>}
    </section>)}
    {entry.connection.cleanup&&<p>This existing Figma link is outside app scope. Removal is deferred until Figma editing resumes.</p>}
    {entry.previews.map(preview=><figure key={preview.path}><img src={previewAssets[`../${preview.path}`]} alt={preview.alt??`${entry.name} on ${preview.platform??'native platform'}`}/><figcaption>{preview.platform}</figcaption></figure>)}
    <details><summary>Property mappings and evidence</summary><p>Property review: {entry.properties.status.replaceAll('-',' ')}</p><pre>{JSON.stringify(entry.properties,null,2)}</pre><p>{validation?.evidence.length?validation.evidence.join(', '):'No validation evidence recorded for this platform yet.'}</p></details>
   </article>;
  })}</div>
  {!entries.length&&<p>No matching entries. Try a different name or remove a filter.</p>}
  <nav className="coverage-pagination" aria-label="Coverage pages"><Button hierarchy="secondary" disabled={current===0} onClick={()=>setPage(current-1)}>Previous</Button><Button hierarchy="secondary" disabled={current===lastPage} onClick={()=>setPage(current+1)}>Next</Button></nav>
 </main>;
}
