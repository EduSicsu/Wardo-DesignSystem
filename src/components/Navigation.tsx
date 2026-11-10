'use client';
import { useId, type AnchorHTMLAttributes, type HTMLAttributes, type ReactNode } from 'react';
import { Tabs as AriaTabs, TabList, Tab, TabPanel, Toolbar as AriaToolbar, type Key, type TabProps } from 'react-aria-components';
import { Button } from './Button';
import { cx } from './shared';
export interface NavigationEntry { id:string; label:string; href:string; icon?:ReactNode; disabled?:boolean; badge?:string|number|null; badgeLabel?:string; }
export type NavigationItemLayout = 'vertical' | 'horizontal' | 'text-only';
export type NavigationItemProps = NavigationEntry & Omit<AnchorHTMLAttributes<HTMLAnchorElement>, 'children' | 'href' | 'id'> & {current?:boolean; layout?:NavigationItemLayout};
export function NavigationItem({id: _destinationId,label,href,icon,current,disabled,badge,badgeLabel,layout='horizontal',className,onClick,...props}:NavigationItemProps) {
 const badgeId=useId();
 const hasBadge=badge!=null;
 const description=[props['aria-describedby'],hasBadge?badgeId:undefined].filter(Boolean).join(' ')||undefined;
 return <a {...props} className={cx('wardo-navigation-item',className)} data-layout={layout}
  href={disabled?undefined:href} role={disabled?'link':props.role} tabIndex={disabled?-1:props.tabIndex}
  aria-current={current?'page':undefined} aria-disabled={disabled||undefined} aria-describedby={description}
  onClick={event=>{if(disabled){event.preventDefault();return;}onClick?.(event);}}>
  {icon!=null&&layout!=='text-only'?<span className="wardo-navigation-indicator" aria-hidden="true"><span className="wardo-navigation-icon">{icon}</span></span>:null}
  <span className="wardo-navigation-label">{label}</span>
  {hasBadge?<><span className="wardo-navigation-badge" aria-hidden="true">{badge}</span><span id={badgeId} hidden>{badgeLabel??badge}</span></>:null}
 </a>;
}
export function NavigationBar({items,current,label='Main navigation',vertical=false,className,...props}:HTMLAttributes<HTMLElement>&{items:NavigationEntry[];current?:string;label?:string;vertical?:boolean}){return <nav {...props} className={cx('wardo-navigation',className)} aria-label={label} data-vertical={vertical}>{items.map(item=><NavigationItem key={item.id} {...item} current={current===item.id}/>)}</nav>;}
export function BottomNavigationBar(props:Parameters<typeof NavigationBar>[0]){return <NavigationBar {...props} className={cx('wardo-bottom-navigation',props.className)}/>;}
export function SideNavigation(props:Parameters<typeof NavigationBar>[0]){return <NavigationBar {...props} vertical className={cx('wardo-side-navigation',props.className)}/>;}
export function NavigationRail(props:Parameters<typeof NavigationBar>[0]){return <SideNavigation {...props} className={cx('wardo-navigation-rail',props.className)}/>;}
export function WebHeader({brand,children,actions,...props}:HTMLAttributes<HTMLElement>&{brand:ReactNode;actions?:ReactNode}){return <header {...props} className="wardo-web-header"><div>{brand}</div><div className="wardo-header-navigation">{children}</div><div className="wardo-header-actions">{actions}</div></header>;}
export function Toolbar({label='Actions',children,orientation='horizontal'}:{label?:string;children:ReactNode;orientation?:'horizontal'|'vertical'}){return <AriaToolbar aria-label={label} orientation={orientation} className="wardo-toolbar">{children}</AriaToolbar>;}
export function TabItem({variant='underline',...props}:Omit<TabProps,'className'>&{variant?:'underline'|'pill'|'default'}){return <Tab {...props} className="wardo-tab" data-variant={variant}/>;}
export interface TabEntry {id:string;label:string;content:ReactNode;disabled?:boolean;}
export function Tabs({items,label,selectedKey,defaultSelectedKey,onSelectionChange,orientation='horizontal'}:{items:TabEntry[];label:string;selectedKey?:Key;defaultSelectedKey?:Key;onSelectionChange?:(key:Key)=>void;orientation?:'horizontal'|'vertical'}){return <AriaTabs selectedKey={selectedKey} defaultSelectedKey={defaultSelectedKey} onSelectionChange={onSelectionChange} orientation={orientation} className="wardo-tabs"><TabList aria-label={label} items={items}>{item=><TabItem id={item.id} isDisabled={item.disabled}>{item.label}</TabItem>}</TabList>{items.map(item=><TabPanel key={item.id} id={item.id} className="wardo-tab-panel">{item.content}</TabPanel>)}</AriaTabs>;}
export function Breadcrumbs({items,label='Breadcrumb'}:{items:{label:string;href?:string}[];label?:string}){return <nav className="wardo-breadcrumbs" aria-label={label}><ol>{items.map((item,i)=><li key={i}>{item.href&&i<items.length-1?<a href={item.href}>{item.label}</a>:<span aria-current={i===items.length-1?'page':undefined}>{item.label}</span>}</li>)}</ol></nav>;}
export function Pagination({page,totalPages,onPageChange,label='Pagination'}:{page:number;totalPages:number;onPageChange:(page:number)=>void;label?:string}){const total=Math.max(1,Math.floor(totalPages));const active=Math.min(total,Math.max(1,page));const pages=Array.from(new Set([1,...Array.from({length:5},(_,i)=>active+i-2).filter(n=>n>1&&n<total),total])).sort((a,b)=>a-b);return <nav className="wardo-pagination" aria-label={label}><Button size="S" hierarchy="text" disabled={active===1} onClick={()=>onPageChange(active-1)}>Previous</Button>{pages.map((n,i)=><span key={n}>{i>0&&n-pages[i-1]>1?<span aria-hidden="true">…</span>:null}<Button size="S" hierarchy={n===active?'tonal':'text'} aria-label={`Page ${n}`} aria-current={n===active?'page':undefined} onClick={()=>onPageChange(n)}>{n}</Button></span>)}<Button size="S" hierarchy="text" disabled={active===total} onClick={()=>onPageChange(active+1)}>Next</Button></nav>;}
export function PageIndicators({page,count,onPageChange,label='Pages'}:{page:number;count:number;onPageChange:(page:number)=>void;label?:string}){return <nav className="wardo-page-indicators" aria-label={label}>{Array.from({length:Math.max(0,count)},(_,i)=><button key={i} type="button" aria-label={`Go to page ${i+1}`} aria-current={page===i?'page':undefined} onClick={()=>onPageChange(i)}><span/></button>)}</nav>;}
