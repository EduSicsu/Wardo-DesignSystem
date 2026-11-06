'use client';
import { useEffect, useId, useRef, type InputHTMLAttributes, type ReactNode } from 'react';
import { cx, type Condition, type Size } from './shared';
export interface CheckboxProps extends Omit<InputHTMLAttributes<HTMLInputElement>,'size'|'type'> { label:ReactNode; hint?:ReactNode; indeterminate?:boolean; size?:Size; condition?:Condition; }
export function Checkbox({label,hint,indeterminate=false,size='M',condition='normal',className,id,...props}:CheckboxProps){
  const generated=useId();const fieldId=id??generated;const ref=useRef<HTMLInputElement>(null);
  useEffect(()=>{if(ref.current)ref.current.indeterminate=indeterminate;},[indeterminate]);
  return <label className={cx('wardo-selection',className)} data-wardo-size={size} data-wardo-condition={condition} htmlFor={fieldId}><input {...props} ref={ref} id={fieldId} type="checkbox" aria-describedby={[props['aria-describedby'],hint?`${fieldId}-hint`:undefined].filter(Boolean).join(' ')||undefined}/><span>{label}{hint?<small id={`${fieldId}-hint`}>{hint}</small>:null}</span></label>;
}
export function Switch({label,hint,size='M',condition='normal',className,id,...props}:Omit<CheckboxProps,'indeterminate'>){
  const generated=useId();const fieldId=id??generated;
  return <label className={cx('wardo-selection','wardo-switch',className)} data-wardo-size={size} data-wardo-condition={condition} htmlFor={fieldId}><input {...props} id={fieldId} type="checkbox" role="switch" aria-describedby={[props['aria-describedby'],hint?`${fieldId}-hint`:undefined].filter(Boolean).join(' ')||undefined}/><span>{label}{hint?<small id={`${fieldId}-hint`}>{hint}</small>:null}</span></label>;
}
export interface RadioGroupProps { label:string; name:string; value?:string; defaultValue?:string; onValueChange?:(value:string)=>void; disabled?:boolean; options:{value:string;label:string;disabled?:boolean}[]; }
export function RadioGroup({label,name,value,defaultValue,onValueChange,disabled,options}:RadioGroupProps){
  return <fieldset className="wardo-radio-group" disabled={disabled}><legend>{label}</legend>{options.map(option=><label className="wardo-selection" key={option.value}><input type="radio" name={name} value={option.value} checked={value===undefined?undefined:value===option.value} defaultChecked={value===undefined?defaultValue===option.value:undefined} onChange={()=>onValueChange?.(option.value)} disabled={option.disabled}/><span>{option.label}</span></label>)}</fieldset>;
}
export interface SliderProps extends Omit<InputHTMLAttributes<HTMLInputElement>,'type'|'size'> { label:string; size?:Size; condition?:Condition; }
export function Slider({label,size='M',condition='normal',id,className,...props}:SliderProps){const generated=useId();const fieldId=id??generated;return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition}><label htmlFor={fieldId}>{label}</label><input {...props} id={fieldId} type="range" className="wardo-slider"/></div>;}
