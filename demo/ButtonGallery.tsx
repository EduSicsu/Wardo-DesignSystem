import { useState } from 'react';
import { ArtworkIcon, Button, Checkbox, Select, WardoProvider, type WardoTheme } from '../src';

export function ButtonGallery() {
  const [theme, setTheme] = useState<WardoTheme>('wardo-light');
  const [rtl, setRTL] = useState(false);
  const [disabled, setDisabled] = useState(false);
  const [status, setStatus] = useState('Ready');
  return <WardoProvider theme={theme} style={{background:'var(--color-background-default)',color:'var(--color-text-primary)',minHeight:'100vh'}}>
    <main style={{padding:'1.5rem',maxWidth:800,margin:'auto',overflowWrap:'anywhere'}}>
      <h1>App button examples</h1>
      <Select label="Button theme" value={theme} onChange={event=>setTheme(event.target.value as WardoTheme)}>
        <option value="wardo-light">Wardo Light</option><option value="wardo-dark">Wardo Dark</option>
      </Select>
      <Checkbox label="Right-to-left buttons" checked={rtl} onChange={event=>setRTL(event.target.checked)}/>
      <Checkbox label="Disable buttons" checked={disabled} onChange={event=>setDisabled(event.target.checked)}/>
      <div dir={rtl?'rtl':'ltr'} style={{display:'flex',gap:'1.5rem',flexWrap:'wrap',marginBlock:'1.5rem'}}>
        {(['primary','secondary','tertiary','tonal','text'] as const).map(hierarchy=><section key={hierarchy} aria-label={`${hierarchy} button example`}>
          <h2 style={{fontSize:'1rem'}}>{hierarchy}</h2>
          <Button hierarchy={hierarchy} disabled={disabled} leadingIcon={<ArtworkIcon name="button-plus"/>} onClick={()=>setStatus(`${hierarchy} action activated`)}>Button</Button>
        </section>)}
      </div>
      <p role="status">{status}</p>
    </main>
  </WardoProvider>;
}
