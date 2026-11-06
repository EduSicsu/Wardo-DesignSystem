'use client';
import { Children, cloneElement, createContext, isValidElement, useContext, useId, useState, type HTMLAttributes, type ReactNode } from 'react';
import { Icon } from './Icon';
import { cx, type Size } from './shared';
interface GroupContext { open: string[]; toggle: (id:string, open:boolean)=>void }
const Group = createContext<GroupContext | null>(null);
export interface AccordionProps extends Omit<HTMLAttributes<HTMLDivElement>, 'title' | 'onChange'> {
  title: ReactNode; subtitle?: ReactNode; children?: ReactNode; size?: Size;
  presentation?: 'plain' | 'inset' | 'outlined'; expanded?: boolean; defaultExpanded?: boolean;
  onExpandedChange?: (expanded:boolean)=>void; disabled?: boolean;
  leadingIcon?: ReactNode; trailingIcon?: ReactNode; indicatorPosition?: 'start' | 'end';
  separator?: boolean; selection?: ReactNode; itemId?: string;
}
export function Accordion({title, subtitle, children, size='M', presentation='plain', expanded, defaultExpanded=false, onExpandedChange, disabled=false, leadingIcon, trailingIcon, indicatorPosition='end', separator=true, selection, itemId, className, ...props}: AccordionProps) {
  const generated=useId(); const id=itemId??generated; const group=useContext(Group);
  const [local,setLocal]=useState(defaultExpanded);
  const open=expanded??(group ? group.open.includes(id) : local);
  const triggerId=`${generated}-trigger`, panelId=`${generated}-panel`;
  const toggle=()=>{const next=!open; if(!group)setLocal(next); else group.toggle(id,next);onExpandedChange?.(next);};
  return <div {...props} className={cx('wardo-accordion',className)} data-presentation={presentation} data-wardo-size={size} data-separator={separator} data-open={open}>
    <div className="wardo-accordion-heading"><h3><button id={triggerId} type="button" aria-expanded={open} aria-controls={panelId} disabled={disabled} onClick={toggle} data-indicator-position={indicatorPosition}>
      <span className="wardo-accordion-indicator"><Icon name="chevron-down"/></span>{leadingIcon ? <span className="wardo-icon">{leadingIcon}</span>:null}
      <span className="wardo-accordion-label"><span>{title}</span>{subtitle ? <span className="wardo-accordion-subtitle">{subtitle}</span>:null}</span>{trailingIcon ? <span className="wardo-icon">{trailingIcon}</span>:null}
    </button></h3>{selection}</div>
    <div role="region" id={panelId} aria-labelledby={triggerId} hidden={!open} className="wardo-accordion-panel">{children}</div>
  </div>;
}
export interface AccordionGroupProps extends Omit<HTMLAttributes<HTMLDivElement>,'onChange'> {
  mode?: 'single'|'multiple'; defaultOpenItems?: string[]; openItems?: string[]; onOpenItemsChange?: (items:string[])=>void;
}
export function AccordionGroup({mode='single',defaultOpenItems=[],openItems,onOpenItemsChange,children,className,...props}:AccordionGroupProps) {
  const [local,setLocal]=useState(defaultOpenItems); const open=openItems??local;
  const toggle=(id:string,expanded:boolean)=>{const next=expanded?(mode==='single'?[id]:[...open.filter(x=>x!==id),id]):open.filter(x=>x!==id);if(openItems===undefined)setLocal(next);onOpenItemsChange?.(next);};
  return <Group.Provider value={{open,toggle}}><div {...props} className={cx('wardo-accordion-group',className)}>{Children.map(children,(child,index)=>isValidElement<AccordionProps>(child)&&child.type===Accordion ? cloneElement(child,{itemId:child.props.itemId??String(index)}) : child)}</div></Group.Provider>;
}
