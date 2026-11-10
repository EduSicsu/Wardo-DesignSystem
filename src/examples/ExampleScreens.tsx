'use client';
import { useRef, useState, type ReactNode } from 'react';
import { ActionChip } from '../components/ActionChip';
import { Avatar } from '../components/DataDisplay';
import { Button } from '../components/Button';
import { ContentCard } from '../components/Content';
import { MenuButton } from '../components/Menus';
import { WardoProvider } from '../components/Provider';
import { exampleAssets } from './assets';
import './examples.css';
export type ExampleLayout='mobile'|'web';
export type ExampleKind='upcoming'|'reviews'|'messaging';
type Assets=Record<string,string>;
function Artwork({src,label=''}:{src?:string;label?:string}){return src?<img className="example-artwork" src={src} alt={label}/>:null;}
function Control({label,src,onClick,children}:{label:string;src?:string;onClick?:()=>void;children?:ReactNode}){return <Button hierarchy="text" size="XS" className="example-control" aria-label={label} onClick={onClick}>{src?<Artwork src={src}/>:children}</Button>;}
function StatusBar({assets}:{assets:Assets}){return <div className="example-statusbar" aria-hidden="true"><span>9:30</span><span className="example-camera"><Artwork src={assets.imgCameraCutout}/></span><span className="example-signal"><Artwork src={assets.imgWifi}/><Artwork src={assets.imgSignal}/><Artwork src={assets.imgBattery}/></span></div>;}
function BrowserBar({assets}:{assets:Assets}){return <div className="example-browserbar" aria-hidden="true"><Artwork src={assets.imgBack}/><Artwork src={assets.imgForward}/><Artwork src={assets.imgRefresh}/><span className="example-address"><Artwork src={assets.imgLock}/>wardo.app<Artwork src={assets.imgStar}/></span><span className="example-browser-avatar">W</span><Artwork src={assets.imgMore}/></div>;}
function Nav({layout,assets,offset=0,onSelect}:{layout:ExampleLayout;assets:Assets;offset?:number;onSelect?:(id:string)=>void}){
 const [active,setActive]=useState('explore');
 return <nav className={`example-navigation ${layout==='web'?'example-rail':''}`} aria-label="Example navigation">
 {layout==='web'&&<><Control label="Open navigation" src={assets[`imgIcon${offset}`]} onClick={()=>onSelect?.('navigation')}/><Control label="Create a plan" src={assets[`imgIcon${offset+1}`]} onClick={()=>onSelect?.('create')}/></>}
 {['explore','saved','inbox'].map((id,index)=><Button key={id} hierarchy="text" size="XS" className="example-nav-item" aria-current={active===id?'page':undefined} onClick={()=>{setActive(id);onSelect?.(id);}}><span className="example-nav-symbol"><Artwork src={assets[`imgIcon${offset+(index===0?3:5)}`]??assets[`imgIcon${offset+3}`]}/></span><span>{id[0].toUpperCase()+id.slice(1)}</span></Button>)}
 </nav>;
}
function Frame({kind,layout,assets,children}:{kind:ExampleKind;layout:ExampleLayout;assets:Assets;children:ReactNode}){
 return <WardoProvider theme="wardo-light" className="example-provider"><div className={`wardo-example example-${kind} example-${layout}`}>
 {layout==='web'?<BrowserBar assets={assets}/>:<StatusBar assets={assets}/>}{children}{layout==='mobile'&&<div className="example-home-indicator" aria-hidden="true"/>}
 </div></WardoProvider>;
}
function Overflow({label,onSelect,src}:{label:string;onSelect:(action:string)=>void;src:string}){return <span className="example-overflow"><MenuButton showTrailingIcon={false} label={<><Artwork src={src}/><span className="example-sr">More options for {label}</span></>} items={[{id:'save',label:'Save to plans'},{id:'share',label:'Share'}]} onAction={key=>onSelect(String(key))}/></span>;}
export interface WardoEvent {id:string;title:string;when:string;image:string;}
export interface UpcomingExampleProps {layout?:ExampleLayout;events?:WardoEvent[];onOpenEvent?:(event:WardoEvent)=>void;onBack?:()=>void;onNavigate?:(destination:string)=>void;onEventAction?:(action:string,event:WardoEvent)=>void;}
export function UpcomingExample({layout='mobile',events,onOpenEvent,onBack,onNavigate,onEventAction}:UpcomingExampleProps){
 const assets:Assets=exampleAssets[`upcoming-${layout}`];const [notice,setNotice]=useState('');const [all,setAll]=useState(false);
 const items=events??[
 {id:'market',title:'Riverside Night Market',when:'Fri, 7 PM · Riverside Square',image:assets.imgItem1},
 {id:'cinema',title:'Courtyard Cinema',when:'Fri, 8:30 PM · Old Town',image:assets.imgItem2},
 {id:'clay',title:'Clay Studio',when:'Sat, 11 AM · Arts District',image:assets.imgItem3??assets.imgThumbnail},
 {id:'jazz',title:'Jazz at Lantern Room',when:'Sat, 8 PM · Lantern Room',image:layout==='web'?assets.imgThumbnail:assets.imgThumbnail1},
 {id:'garden',title:'Garden Walk',when:'Sun, 9 AM · Botanical Garden',image:assets.imgItem4??assets.imgThumbnail2}];
 function select(event:WardoEvent){setNotice(`${event.title} · ${event.when}`);onOpenEvent?.(event);}
 return <Frame kind="upcoming" layout={layout} assets={assets}><div className="example-app-layout">
 {layout==='web'&&<Nav layout={layout} assets={assets} offset={5} onSelect={onNavigate}/>}
 <section className="example-app-panel" aria-label="Weekend plans">
 <div className="example-top-actions"><Control label="Back" src={assets.imgIcon} onClick={()=>{onBack?.();setNotice('Back selected');}}/><span/><Control label="Attach a plan" src={assets.imgIcon1} onClick={()=>setNotice('Choose a plan to attach')}/><Control label="Open calendar" src={assets.imgIcon2} onClick={()=>{setAll(true);setNotice('Upcoming events shown');}}/><Overflow src={assets.imgIcon3} label="Weekend plans" onSelect={action=>setNotice(action==='save'?'Weekend plans saved':'Weekend plans ready to share')}/></div>
 <h1>Weekend plans</h1><div className="example-event-carousel" role="region" aria-label="Featured plans" tabIndex={0}>{items.slice(0,layout==='mobile'?2:4).map(item=><button key={item.id} className="example-event-image" type="button" onClick={()=>select(item)} aria-label={`View ${item.title}`}><img src={item.image} alt={item.title}/></button>)}</div>
 <Button hierarchy="text" size="XS" className="example-see-all" onClick={()=>{setAll(!all);setNotice(all?'Featured plans shown':'All upcoming plans shown');}}>{all?'Show featured':'See all'}</Button>
 <h2>Coming up <Artwork src={assets.imgIcon4}/></h2>
 <div className="example-event-list">{items.map(item=><div className="example-event-row" key={item.id}><Button hierarchy="text" size="XS" className="example-event-open" onClick={()=>select(item)}><img className="example-event-thumbnail" src={item.image} alt=""/><span><strong>{item.title}</strong><small>{item.when}</small></span></Button><Overflow src={assets.imgIcon3} label={item.title} onSelect={action=>{setNotice(`${item.title} ${action==='save'?'saved':'ready to share'}`);onEventAction?.(action,item);}}/><span className="example-divider" aria-hidden="true"><Artwork src={assets.imgDivider1??assets.imgDivider}/></span></div>)}</div>
 {notice&&<p className="example-feedback" role="status">{notice}</p>}
 </section></div></Frame>;
}
export function UpcomingMobileExample(props:Omit<UpcomingExampleProps,'layout'>){return <UpcomingExample {...props} layout="mobile"/>;}
export function UpcomingWebExample(props:Omit<UpcomingExampleProps,'layout'>){return <UpcomingExample {...props} layout="web"/>;}
export interface WardoPlace {id:string;name:string;category:string;description:string;distance:number;rating:number;image:string;}
export interface ReviewsExampleProps {layout?:ExampleLayout;places?:WardoPlace[];onPlaceSelect?:(place:WardoPlace)=>void;onSavedChange?:(ids:Set<string>)=>void;onSeeAll?:()=>void;onNavigate?:(destination:string)=>void;}
export function ReviewsExample({layout='mobile',places,onPlaceSelect,onSavedChange,onSeeAll,onNavigate}:ReviewsExampleProps){
 const assets:Assets=exampleAssets[`reviews-${layout}`];const [saved,setSaved]=useState(new Set<string>());const [filter,setFilter]=useState('rated');const [notice,setNotice]=useState('');
 const items=places??[{id:'bakes',name:'Morning Bakes',category:'Bakery · $$ · 0.4 mi',description:'Fresh pastries and excellent coffee.',distance:.4,rating:5,image:assets.imgImage},{id:'table',name:'The Green Table',category:'Seasonal · $$$ · 0.8 mi',description:'Vegetable plates worth sharing.',distance:.8,rating:5,image:assets.imgImageAlbumArt},{id:'kitchen',name:'Market Kitchen',category:'Street food · $$ · 1.2 mi',description:'Bright flavors after the night market.',distance:1.2,rating:5,image:assets.imgImage1}];
 const sorted=[...items].sort((a,b)=>filter==='nearby'?a.distance-b.distance:b.rating-a.rating);
 function toggle(id:string){const next=new Set(saved);if(next.has(id))next.delete(id);else next.add(id);setSaved(next);onSavedChange?.(next);setNotice(next.has(id)?'Place saved':'Place removed from saved');}
 return <Frame kind="reviews" layout={layout} assets={assets}><div className="example-app-layout">
 {layout==='web'&&<Nav layout={layout} assets={assets} offset={0} onSelect={onNavigate}/>}
 <section className="example-app-panel" aria-label="Nearby favorites">
 <div className="example-place-hero"><img className="example-place-cover" src={assets.imgImageAlbumArt} alt="Green Table restaurant"/>
 <Control label="Back" src={layout==='mobile'?assets.imgIcon:assets.imgIcon6} onClick={()=>{setNotice('Back selected');onNavigate?.('back');}}/>
 <div className="example-place-title"><h1>Green Table</h1><p>Seasonal neighborhood cooking</p><div><ActionChip size="XS" className="example-place-action" onClick={()=>{toggle('table');}}><Artwork src={layout==='mobile'?assets.imgIcon1:assets.imgIcon7}/>Save to plans</ActionChip><ActionChip size="XS" className="example-place-action" onClick={()=>setNotice('Green Table is a 12 minute walk away')}><Artwork src={layout==='mobile'?assets.imgIcon2:assets.imgIcon8}/>12 min walk</ActionChip></div></div>
 </div>
 {layout==='mobile'&&<div className="example-reviews-heading"><h2>Nearby favorites</h2><p>Within 2 miles · $$–$$$</p></div>}
 <div className="example-review-filters" role="group" aria-label="Sort places"><ActionChip size="S" selected={filter==='rated'} className="example-review-filter" onClick={()=>setFilter('rated')}><Artwork src={layout==='mobile'?assets.imgIcon4:assets.imgIcon10}/>Top rated</ActionChip><ActionChip size="S" selected={filter==='nearby'} className="example-review-filter" onClick={()=>setFilter('nearby')}>Nearby</ActionChip></div>
 <div>{sorted.map(place=><div className="example-place-row" key={place.id}><Button hierarchy="text" size="XS" className="example-place-open" onClick={()=>{setNotice(place.name);onPlaceSelect?.(place);}}><img className="example-place-thumbnail" src={place.image} alt=""/><span className="example-place-summary"><span className="example-place-head"><strong>{place.name}</strong><span role="img" aria-label={`${place.rating} out of 5 stars`} className="example-rating">{Array.from({length:5},(_,index)=><Artwork key={index} src={assets.imgReviewStar01}/>)}</span></span><small>{place.category}</small><span className="example-place-description">{place.description}</span></span></Button><Button hierarchy="text" size="XS" className="example-favorite" aria-label={`${saved.has(place.id)?'Unsave':'Save'} ${place.name}`} aria-pressed={saved.has(place.id)} onClick={()=>toggle(place.id)}><Artwork src={layout==='mobile'?assets.imgIcon5:assets.imgIcon11}/></Button><span className="example-divider" aria-hidden="true"><Artwork src={assets.imgDivider}/></span></div>)}</div>
 {layout==='mobile'&&<Button hierarchy="tertiary" size="S" className="example-all-places" onClick={()=>{setNotice(`Showing ${items.length} sample places`);onSeeAll?.();}}>See all 28 places</Button>}
 {notice&&<p className="example-feedback" role="status">{notice}</p>}
 </section></div>{layout==='mobile'&&<Nav layout={layout} assets={assets} offset={4} onSelect={onNavigate}/>}</Frame>;
}
export function ReviewsMobileExample(props:Omit<ReviewsExampleProps,'layout'>){return <ReviewsExample {...props} layout="mobile"/>;}
export function ReviewsWebExample(props:Omit<ReviewsExampleProps,'layout'>){return <ReviewsExample {...props} layout="web"/>;}
export interface WardoMessage {id:string;body:string;outgoing?:boolean;image?:string;}
export interface MessagingExampleProps {layout?:ExampleLayout;initialMessages?:WardoMessage[];onSend?:(message:WardoMessage)=>void;onAttachment?:(file:File)=>void;onBack?:()=>void;}
export function MessagingExample({layout='mobile',initialMessages,onSend,onAttachment,onBack}:MessagingExampleProps){
 const assets:Assets=exampleAssets[`messaging-${layout}`];const [name,setName]=useState('Maya');const [draft,setDraft]=useState('');const [search,setSearch]=useState(false);const [query,setQuery]=useState('');const [notice,setNotice]=useState('');const [replied,setReplied]=useState(false);const file=useRef<HTMLInputElement>(null);const nextId=useRef(0);
 const [messages,setMessages]=useState<WardoMessage[]>(initialMessages??[...(layout==='mobile'?[{id:'friday',body:'Friday is free!'},{id:'market',body:'Night market first?'},{id:'dinner',body:'Then dinner?'}]:[]),{id:'event',body:'Riverside Night Market\nwardo.app/events',image:assets.imgImage,outgoing:true},{id:'seven',body:'Let’s meet at seven?',outgoing:true},{id:'perfect',body:'Perfect!'}]);
 function send(body:string){if(!body.trim())return;const message={id:`sent-${++nextId.current}`,body:body.trim(),outgoing:true};setMessages(current=>[...current,message]);setDraft('');setReplied(true);onSend?.(message);}
 const contacts=[['Maya','Friday is free!','2 min'],['Alex','Meet at seven?','12 min'],['Jordan','Saved the market','25 min'],['Lena','Clay studio Saturday','1 hr'],['Noah','Dinner looks great','2 hr'],['Sofia','Garden walk Sunday','3 hr'],['Theo','I can bring tickets','1 d'],['Iris','See you soon','2 d']];
 return <Frame kind="messaging" layout={layout} assets={assets}><div className="example-app-layout">
 {layout==='web'&&<aside className="example-conversations" aria-label="Conversations"><h2>Messages</h2>{contacts.map(([person,preview,time])=><button key={person} type="button" aria-current={name===person?'true':undefined} onClick={()=>{setName(person);setNotice(`Conversation with ${person}`);}}><Avatar name={person}/><span><strong>{person}</strong><small>{preview}</small></span><time>{time}</time></button>)}</aside>}
 <section className="example-app-panel" aria-label={`Conversation with ${name}`}><div className="example-chat-header"><Control label="Back" src={assets.imgIcon} onClick={()=>{onBack?.();setNotice("Back selected");}}/><h1>{name}</h1><Control label="Attach image" src={assets.imgIcon1} onClick={()=>file.current?.click()}/><Overflow src={assets.imgIcon2} label="Conversation" onSelect={action=>setNotice(action==='save'?'Conversation saved':'Conversation ready to share')}/></div>
 {search&&<label className="example-chat-search">Search messages<input type="search" value={query} onChange={event=>setQuery(event.target.value)}/></label>}
 <div className="example-chat-history" role="log" aria-label="Messages" aria-live="polite">{messages.filter(message=>message.body.toLowerCase().includes(query.toLowerCase())).map((message,index)=><div key={message.id} className={`example-message ${message.outgoing?'example-outgoing':''}`}>{!message.outgoing&&<Avatar name={name} size={36}/>}<div>{index===1&&layout==='mobile'&&<p className="example-day">Today</p>}{message.image?<ContentCard className="example-chat-card" appearance="filled" media={<img src={message.image} alt="Riverside Night Market"/>}>{message.body.split('\n').map(line=><span key={line}>{line}<br/></span>)}</ContentCard>:<p className="example-bubble">{message.body}</p>}</div></div>)}</div>
 {!replied&&<div className="example-quick-replies">{['7 works','I’m in','See you'].map(reply=><ActionChip size="S" key={reply} onClick={()=>send(reply)}>{reply}</ActionChip>)}</div>}
 <form className="example-composer" onSubmit={event=>{event.preventDefault();send(draft);}}><Control label="Add attachment" src={assets.imgAddCircle} onClick={()=>file.current?.click()}/><Control label="Add smile" src={assets.imgMood} onClick={()=>setDraft(value=>value+' ☺')}/><Control label="Message options" src={assets.imgIcon3} onClick={()=>setNotice('Press Enter to send a message')}/><label className="example-message-input"><span className="example-sr">Message</span><input value={draft} onChange={event=>setDraft(event.target.value)} autoComplete="off"/></label>{draft.trim()?<Button type="submit" hierarchy="text" size="XS">Send</Button>:<Control label="Search conversation" src={assets.imgIcon4} onClick={()=>setSearch(value=>!value)}/>}</form>
 <input ref={file} type="file" accept="image/*" hidden onChange={event=>{const selected=event.target.files?.[0];if(selected){onAttachment?.(selected);setNotice(`${selected.name} selected`);}}}/>
 {notice&&<p className="example-feedback" role="status">{notice}</p>}
 </section></div></Frame>;
}
export function MessagingMobileExample(props:Omit<MessagingExampleProps,'layout'>){return <MessagingExample {...props} layout="mobile"/>;}
export function MessagingWebExample(props:Omit<MessagingExampleProps,'layout'>){return <MessagingExample {...props} layout="web"/>;}
