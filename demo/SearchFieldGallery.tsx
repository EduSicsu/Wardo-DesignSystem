import { useState } from 'react';
import { Button, Checkbox, SearchField, Select, WardoProvider, type WardoTheme } from '../src';

export function SearchFieldGallery() {
  const [query, setQuery] = useState('Ceramics');
  const [rtl, setRTL] = useState(false);
  const [disabled, setDisabled] = useState(false);
  const [theme, setTheme] = useState<WardoTheme>('wardo-light');
  const [status, setStatus] = useState('Ready');
  return <WardoProvider theme={theme}>
    <main style={{padding:'1.5rem',maxWidth:720,margin:'auto',overflowWrap:'anywhere'}}>
      <h1>Search field examples</h1>
      <Select label="Search theme" value={theme} onChange={event=>setTheme(event.target.value as WardoTheme)}>
        <option value="wardo-light">Wardo Light</option><option value="wardo-dark">Wardo Dark</option>
      </Select>
      <Checkbox label="Right-to-left search" checked={rtl} onChange={event=>setRTL(event.target.checked)}/>
      <Checkbox label="Disable search" checked={disabled} onChange={event=>setDisabled(event.target.checked)}/>
      <h2>Navigation search</h2>
      <form aria-label="Navigation search example" onSubmit={event=>{event.preventDefault();setStatus(`Search submitted: ${query}`);}}>
        <div style={{width:320,maxWidth:'100%'}}>
          <SearchField label="Search navigation" presentation="navigation" name="query" value={query}
            onChange={event=>setQuery(event.target.value)} placeholder="Search events" dir={rtl?'rtl':'ltr'} disabled={disabled}/>
        </div>
        <Button type="submit" disabled={disabled}>Search</Button>
      </form>
      <p role="status">{status}</p>
      <output aria-label="Current search query">{query||'Empty query'}</output>
    </main>
  </WardoProvider>;
}
