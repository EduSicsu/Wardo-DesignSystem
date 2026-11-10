'use client';
import { useId, useRef, useState, type HTMLAttributes, type InputHTMLAttributes, type ReactNode, type TextareaHTMLAttributes, type SelectHTMLAttributes, type Ref } from 'react';
import { Button } from './Button';
import { Icon } from './Icon';
import { cx, type Condition, type Size } from './shared';
export interface FieldBase { label: string; hint?: ReactNode; error?: ReactNode; size?: Size; condition?: Condition; appearance?: 'outlined'|'filled'; }
export interface TextFieldProps extends Omit<InputHTMLAttributes<HTMLInputElement>,'size'>, FieldBase { leadingIcon?: ReactNode; trailingAction?: ReactNode; inputRef?: Ref<HTMLInputElement>; }
/** Field construction part. Compose inside TextField's labelled field shell. */
export function FieldChrome({leadingIcon,trailingAction,children,className,...props}:HTMLAttributes<HTMLDivElement>&{leadingIcon?:ReactNode;trailingAction?:ReactNode}) {
  return <div {...props} className={cx('wardo-field-control',className)}>{leadingIcon?<span className="wardo-icon">{leadingIcon}</span>:null}{children}{trailingAction}</div>;
}
/** Native editable content; its owner supplies the label, value, and callbacks. */
export function FieldContent({inputRef,...props}:InputHTMLAttributes<HTMLInputElement>&{inputRef?:Ref<HTMLInputElement>}) {
  return <input {...props} ref={inputRef}/>;
}
/** Supporting content is associated with its input through aria-describedby. */
export function FieldSupportingText({className,...props}:HTMLAttributes<HTMLDivElement>) {
  return <div {...props} className={cx('wardo-field-message',className)}/>;
}
export function TextField({label,hint,error,size='M',condition='normal',appearance='outlined',id,className,leadingIcon,trailingAction,inputRef,...props}:TextFieldProps) {
  const autoId=useId(); const fieldId=id??autoId; const messageId=`${fieldId}-message`;
  const described=[props['aria-describedby'], error || hint ? messageId : undefined].filter(Boolean).join(' ')||undefined;
  return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition} data-appearance={appearance} data-invalid={!!error}>
    <label htmlFor={fieldId}>{label}{props.required ? <span aria-hidden="true"> *</span>:null}</label>
    <FieldChrome leadingIcon={leadingIcon} trailingAction={trailingAction}><FieldContent {...props} inputRef={inputRef} id={fieldId} aria-invalid={error?true:props['aria-invalid']} aria-describedby={described}/></FieldChrome>
    {error||hint ? <FieldSupportingText id={messageId}>{error||hint}</FieldSupportingText>:null}
  </div>;
}
export function PasswordField(props:Omit<TextFieldProps,'type'|'trailingAction'>) {
  const [visible,setVisible]=useState(false);
  return <TextField {...props} type={visible?'text':'password'} autoComplete={props.autoComplete??'current-password'} trailingAction={<Button hierarchy="text" size="XS" aria-label={visible?'Hide password':'Show password'} aria-pressed={visible} disabled={props.disabled} onClick={()=>setVisible(v=>!v)}><Icon name={visible?'eye-off':'eye'}/></Button>}/>;
}
export interface SearchFieldProps extends Omit<TextFieldProps,'type'|'inputRef'> { clearLabel?: string; clearable?: boolean; onClear?: () => void; presentation?: 'field'|'toolbar-top'|'toolbar-bottom'; }
export function SearchField({clearLabel='Clear search',clearable=true,onClear,trailingAction,spellCheck=false,presentation='field',className,...props}:SearchFieldProps){
  const input=useRef<HTMLInputElement>(null);
  const [uncontrolledValue,setUncontrolledValue]=useState(String(props.defaultValue??''));
  const value=props.value??uncontrolledValue;
  function clear(){
    const element=input.current;
    if(!element)return;
    Object.getOwnPropertyDescriptor(HTMLInputElement.prototype,'value')?.set?.call(element,'');
    element.dispatchEvent(new Event('input',{bubbles:true}));
    setUncontrolledValue('');onClear?.();element.focus();
  }
  return <TextField leadingIcon={<Icon name="search"/>} {...props} className={cx('wardo-search',`wardo-search--${presentation}`,className)} spellCheck={spellCheck} inputRef={input} type="search" onChange={event=>{setUncontrolledValue(event.target.value);props.onChange?.(event);}} trailingAction={<>{clearable&&String(value).length>0&&!props.readOnly?<button className="wardo-field-clear" type="button" aria-label={clearLabel} disabled={props.disabled} onClick={clear}><Icon name="close"/></button>:null}{trailingAction}</>}/>;
}
export function NumberField(props:Omit<TextFieldProps,'type'>){return <TextField {...props} type="number"/>;}
export interface TextAreaProps extends TextareaHTMLAttributes<HTMLTextAreaElement>, FieldBase {}
export function TextArea({label,hint,error,size='M',condition='normal',appearance='outlined',id,className,...props}:TextAreaProps){
  const autoId=useId();const fieldId=id??autoId;const messageId=`${fieldId}-message`;
  return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition} data-appearance={appearance} data-invalid={!!error}><label htmlFor={fieldId}>{label}</label><textarea {...props} id={fieldId} aria-invalid={error?true:props['aria-invalid']} aria-describedby={[props['aria-describedby'],error||hint?messageId:undefined].filter(Boolean).join(' ')||undefined}/>{error||hint?<div className="wardo-field-message" id={messageId}>{error||hint}</div>:null}</div>;
}
export interface SelectProps extends Omit<SelectHTMLAttributes<HTMLSelectElement>,'size'>, FieldBase {}
export function Select({label,hint,error,size='M',condition='normal',appearance='outlined',id,className,children,...props}:SelectProps){
  const autoId=useId();const fieldId=id??autoId;const messageId=`${fieldId}-message`;
  return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition} data-appearance={appearance} data-invalid={!!error}><label htmlFor={fieldId}>{label}</label><div className="wardo-select-control"><select {...props} id={fieldId} aria-invalid={error?true:props['aria-invalid']} aria-describedby={[props['aria-describedby'],error||hint?messageId:undefined].filter(Boolean).join(' ')||undefined}>{children}</select><span className="wardo-select-chevron" aria-hidden="true"><Icon name="chevron-down"/></span></div>{error||hint?<div className="wardo-field-message" id={messageId}>{error||hint}</div>:null}</div>;
}
