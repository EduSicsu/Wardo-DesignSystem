'use client';
import { useId, useState, type InputHTMLAttributes, type ReactNode, type TextareaHTMLAttributes, type SelectHTMLAttributes } from 'react';
import { Button } from './Button';
import { Icon } from './Icon';
import { cx, type Condition, type Size } from './shared';
export interface FieldBase { label: string; hint?: ReactNode; error?: ReactNode; size?: Size; condition?: Condition; appearance?: 'outlined'|'filled'; }
export interface TextFieldProps extends Omit<InputHTMLAttributes<HTMLInputElement>,'size'>, FieldBase { leadingIcon?: ReactNode; trailingAction?: ReactNode; }
export function TextField({label,hint,error,size='M',condition='normal',appearance='outlined',id,className,leadingIcon,trailingAction,...props}:TextFieldProps) {
  const autoId=useId(); const fieldId=id??autoId; const messageId=`${fieldId}-message`;
  const described=[props['aria-describedby'], error || hint ? messageId : undefined].filter(Boolean).join(' ')||undefined;
  return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition} data-appearance={appearance} data-invalid={!!error}>
    <label htmlFor={fieldId}>{label}{props.required ? <span aria-hidden="true"> *</span>:null}</label>
    <div className="wardo-field-control">{leadingIcon?<span className="wardo-icon">{leadingIcon}</span>:null}<input {...props} id={fieldId} aria-invalid={error?true:props['aria-invalid']} aria-describedby={described}/>{trailingAction}</div>
    {error||hint ? <div className="wardo-field-message" id={messageId}>{error||hint}</div>:null}
  </div>;
}
export function PasswordField(props:Omit<TextFieldProps,'type'|'trailingAction'>) {
  const [visible,setVisible]=useState(false);
  return <TextField {...props} type={visible?'text':'password'} autoComplete={props.autoComplete??'current-password'} trailingAction={<Button hierarchy="text" size="XS" aria-label={visible?'Hide password':'Show password'} aria-pressed={visible} disabled={props.disabled} onClick={()=>setVisible(v=>!v)}><Icon name={visible?'eye-off':'eye'}/></Button>}/>;
}
export function SearchField(props:Omit<TextFieldProps,'type'>){return <TextField leadingIcon={<Icon name="search"/>} {...props} type="search"/>;}
export function NumberField(props:Omit<TextFieldProps,'type'>){return <TextField {...props} type="number"/>;}
export interface TextAreaProps extends TextareaHTMLAttributes<HTMLTextAreaElement>, FieldBase {}
export function TextArea({label,hint,error,size='M',condition='normal',appearance='outlined',id,className,...props}:TextAreaProps){
  const autoId=useId();const fieldId=id??autoId;const messageId=`${fieldId}-message`;
  return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition} data-appearance={appearance} data-invalid={!!error}><label htmlFor={fieldId}>{label}</label><textarea {...props} id={fieldId} aria-invalid={error?true:props['aria-invalid']} aria-describedby={[props['aria-describedby'],error||hint?messageId:undefined].filter(Boolean).join(' ')||undefined}/>{error||hint?<div className="wardo-field-message" id={messageId}>{error||hint}</div>:null}</div>;
}
export interface SelectProps extends Omit<SelectHTMLAttributes<HTMLSelectElement>,'size'>, FieldBase {}
export function Select({label,hint,error,size='M',condition='normal',appearance='outlined',id,className,children,...props}:SelectProps){
  const autoId=useId();const fieldId=id??autoId;const messageId=`${fieldId}-message`;
  return <div className={cx('wardo-field',className)} data-wardo-size={size} data-wardo-condition={condition} data-appearance={appearance} data-invalid={!!error}><label htmlFor={fieldId}>{label}</label><select {...props} id={fieldId} aria-invalid={error?true:props['aria-invalid']} aria-describedby={[props['aria-describedby'],error||hint?messageId:undefined].filter(Boolean).join(' ')||undefined}>{children}</select>{error||hint?<div className="wardo-field-message" id={messageId}>{error||hint}</div>:null}</div>;
}
