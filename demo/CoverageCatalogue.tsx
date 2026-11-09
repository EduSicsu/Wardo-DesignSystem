import { useMemo, useState } from 'react';
import registryData from '../coverage/registry.json';
interface Binding {status:string; source?:string; symbol?:string; platforms?:string[]; example?:string|null; gaps?:string[]; framework?:string}
interface CatalogueEntry { id:string; nodeId:string; name:string; page:string; category:string; figmaUrl:string; reason?:string; implementation:Binding; alternatives:Binding[]; properties:{status:string; definitions:unknown; mappings:unknown[]}; validation:{status:string; evidence:string[]}; connection:{status:string}; previews:{path:string;alt?:string;platform?:string}[]; }
interface NativePreview {path:string;platform:string;alt:string;caption:string}
const registry: {entries:CatalogueEntry[];samplePreviews:NativePreview[]}=registryData;
import { SearchField, Select, Button } from '../src';
import './coverage.css';
const previewAssets=import.meta.glob<string>('../coverage/previews/**/*.{png,jpg}',{eager:true,query:'?url&no-inline',import:'default'});
const PAGE_SIZE=30;
export function CoverageCatalogue() {
 const [query,setQuery]=useState('');
 const [platform,setPlatform]=useState('all');
 const [state,setState]=useState('all');
 const [page,setPage]=useState(0);
 const entries=useMemo(()=>registry.entries.filter(entry=>{
  const bindings=[entry.implementation,...entry.alternatives];
  return `${entry.name} ${entry.nodeId} ${entry.id} ${bindings.map(binding=>binding.symbol??'').join(' ')}`.toLowerCase().includes(query.toLowerCase())
   && (platform==='all'||bindings.some(binding=>binding.platforms?.includes(platform)))
   && (state==='all'||(state==='references'?!['runtime-candidate','example-composition'].includes(entry.category):state==='validated'?entry.validation.status==='verified':state==='connected'?entry.connection.status==='source-connection-saved':['runtime-candidate','example-composition'].includes(entry.category)&&entry.validation.status!=='verified'));
 }),[query,platform,state]);
 const active=registry.entries.filter(e=>['runtime-candidate','example-composition'].includes(e.category));
 const connected=registry.entries.filter(e=>e.connection.status==='source-connection-saved').length;
 const validated=active.filter(e=>e.validation.status==='verified').length;
 const lastPage=Math.max(0,Math.ceil(entries.length/PAGE_SIZE)-1);
 const current=Math.min(page,lastPage);
 return <main className="coverage-catalogue" data-wardo-theme="wardo-light">
  <a href="/library">← Component gallery</a>
  <h1>Wardo coverage catalogue</h1>
  <p>Find the implementation for a design across web, Apple, and Android. Source availability, validation, and Figma connections are tracked separately.</p>
  <dl className="coverage-metrics"><div><dt>Published entries</dt><dd>{registry.entries.length}</dd></div><div><dt>Active components & examples</dt><dd>{active.length}</dd></div><div><dt>Validated active entries</dt><dd>{validated} / {active.length}</dd></div><div><dt>Saved Figma links</dt><dd>{connected} / {registry.entries.length}</dd></div></dl>
  <details className="coverage-native-previews"><summary>Native sample previews</summary><p>Running sample applications. Per-entry verification remains recorded separately below.</p><div>{registry.samplePreviews.map(preview=><figure key={preview.path}><a href={previewAssets[`../${preview.path}`]}><img loading="lazy" src={previewAssets[`../${preview.path}`]} alt={preview.alt}/></a><figcaption>{preview.caption}</figcaption></figure>)}</div></details>
  <div className="coverage-filters"><SearchField label="Find a design or component" placeholder="Name, source symbol, or node ID" value={query} onChange={event=>{setQuery(event.target.value);setPage(0);}}/><Select label="Platform" value={platform} onChange={event=>{setPlatform(event.target.value);setPage(0);}}>{['all','web','iOS','iPadOS','visionOS','Android','Android XR','macOS'].map(p=><option key={p} value={p}>{p==='all'?'All platforms':p}</option>)}</Select><Select label="Coverage" value={state} onChange={event=>{setState(event.target.value);setPage(0);}}><option value="all">All entries</option><option value="pending">Needs validation</option><option value="validated">Validated</option><option value="connected">Connected in Figma</option><option value="references">Archives & references</option></Select></div>
  <p role="status">{entries.length} matching {entries.length===1?'entry':'entries'}. Page {current+1} of {lastPage+1}.</p>
  <div className="coverage-records">{entries.slice(current*PAGE_SIZE,(current+1)*PAGE_SIZE).map(entry=>{
   const implementation=entry.implementation;
   return <article key={entry.id} id={entry.id}><div className="coverage-record-heading"><h2>{entry.name}</h2><a href={entry.figmaUrl}>Open in Figma ↗</a></div><p>{entry.page} · {entry.nodeId} · {entry.category.replaceAll('-',' ')}</p>
    {'reason' in entry&&<p>{entry.reason}</p>}
    <dl className="coverage-states"><div><dt>Implementation</dt><dd>{implementation.status.replaceAll('-',' ')}</dd></div><div><dt>Validation</dt><dd>{entry.validation.status}</dd></div><div><dt>Figma</dt><dd>{entry.connection.status.replaceAll('-',' ')}</dd></div></dl>
    {[implementation,...entry.alternatives].filter(binding=>binding.source).map(binding=><section key={`${binding.source}:${binding.symbol}`} aria-label={`${binding.framework??''} implementation`}>
     <p><a href={`https://github.com/EduSicsu/Wardo-DesignSystem/blob/${import.meta.env.VITE_WARDO_SOURCE_REF ?? 'main'}/${binding.source}`}>{binding.symbol??binding.source}</a> · {binding.platforms?.join(', ')}</p>
     {binding.example&&<pre><code>{binding.example}</code></pre>}
     {!!binding.gaps?.length&&<><p>Outstanding review:</p><ul>{binding.gaps.map(gap=><li key={gap}>{gap}</li>)}</ul></>}
    </section>)}
    {entry.previews.map(preview=><figure key={preview.path}><img src={previewAssets[`../${preview.path}`]} alt={preview.alt??`${entry.name} on ${preview.platform??'native platform'}`}/><figcaption>{preview.platform}</figcaption></figure>)}
    <details><summary>Property mappings and evidence</summary><p>Property review: {entry.properties.status.replaceAll('-',' ')}</p><pre>{JSON.stringify(entry.properties,null,2)}</pre><p>{entry.validation.evidence.length?entry.validation.evidence.join(', '):'No per-entry validation evidence recorded yet.'}</p></details>
   </article>;
  })}</div>
  {!entries.length&&<p>No matching entries. Try a different name or remove a filter.</p>}
  <nav className="coverage-pagination" aria-label="Coverage pages"><Button hierarchy="secondary" disabled={current===0} onClick={()=>setPage(current-1)}>Previous</Button><Button hierarchy="secondary" disabled={current===lastPage} onClick={()=>setPage(current+1)}>Next</Button></nav>
 </main>;
}
