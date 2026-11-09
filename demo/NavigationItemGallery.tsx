import { useState } from 'react';
import { Checkbox, Icon, NavigationItem, Select, WardoProvider, type NavigationItemLayout, type WardoTheme } from '../src';

const themes: WardoTheme[] = ['wardo-light','wardo-dark','ocean-light','ocean-dark','orchid-light','orchid-dark','ember-light','ember-dark','cloud-light','cloud-dark'];
const layouts: NavigationItemLayout[] = ['horizontal','vertical','text-only'];
export function NavigationItemGallery() {
 const [theme,setTheme]=useState<WardoTheme>('wardo-light');
 const [disabled,setDisabled]=useState(false);
 const [activated,setActivated]=useState('None');
 return <WardoProvider theme={theme}>
  <main style={{padding:24,maxWidth:1100,margin:'auto',color:'var(--color-text-primary)',background:'var(--color-background-default)',minHeight:'100vh'}}>
   <a href="/library">Component library</a><h1>Navigation item variants</h1>
   <div style={{display:'flex',gap:24,alignItems:'end',flexWrap:'wrap',maxWidth:650}}>
    <Select label="Preview theme" value={theme} onChange={event=>setTheme(event.target.value as WardoTheme)}>{themes.map(value=><option key={value}>{value}</option>)}</Select>
    <Checkbox label="Disable destinations" checked={disabled} onChange={event=>setDisabled(event.target.checked)}/>
   </div>
   <p role="status">Activated: {activated}</p>
   <div aria-hidden="true" style={{display:'flex',gap:24,marginBlock:24}}>{(['events','saved','notifications','profile'] as const).map(name=><Icon key={name} name={name} width={24} height={24}/>)}</div>
   <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fit,minmax(min(100%,260px),1fr))',gap:24}}>
    {(['ltr','rtl'] as const).flatMap(dir=>layouts.flatMap(layout=>[false,true].map(current=>{
     const key=`${dir}-${layout}-${current?'current':'idle'}`;
     return <section key={key} className="navigation-item-fixture" data-direction={dir} data-layout={layout} data-current={current}>
      <h2 style={{fontSize:14}}>{layout} · {current?'current':'idle'} · {dir}</h2>
      <div dir={dir}><NavigationItem id={key} label="Events" href={`#${key}`} layout={layout} current={current} disabled={disabled} icon={<Icon name="events" width={24} height={24}/>} badge={3} badgeLabel="3 unread events" onClick={event=>{event.preventDefault();setActivated(key);}}/></div>
     </section>;
    })))}
   </div>
  </main>
 </WardoProvider>;
}
