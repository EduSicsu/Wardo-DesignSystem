'use client';
import { useState, type ReactNode } from 'react';
import { Dialog, type DialogProps } from './Overlays';
import { TextField, type TextFieldProps } from './TextField';
import { DatePicker, AmountField, PostalAddress } from './AdvancedInputs';
import { Button } from './Button';
export function CommandSheet({commands,...props}:Omit<DialogProps,'children'>&{commands:{id:string;label:string;onAction:()=>void;disabled?:boolean}[]}){const [query,setQuery]=useState('');return <Dialog {...props}><TextField label="Search commands" type="search" value={query} onChange={e=>setQuery(e.target.value)}/><ul className="wardo-command-list">{commands.filter(c=>c.label.toLowerCase().includes(query.toLowerCase())).map(c=><li key={c.id}><Button hierarchy="text" disabled={c.disabled} onClick={c.onAction}>{c.label}</Button></li>)}</ul>{!commands.some(c=>c.label.toLowerCase().includes(query.toLowerCase()))?<p role="status">No commands found</p>:null}</Dialog>;}
export function DataInput({kind='text',...props}:TextFieldProps&{kind?:'text'|'email'|'tel'|'url'|'date'|'time'|'number'}){return <TextField {...props} type={kind}/>;}
export function DateComposition({label='Date and time',dateName='date',timeName='time',disabled=false}:{label?:string;dateName?:string;timeName?:string;disabled?:boolean}){return <fieldset className="wardo-date-composition" disabled={disabled}><legend>{label}</legend><DatePicker label="Date" name={dateName}/><TextField label="Time" name={timeName} type="time"/></fieldset>;}
export function LocationField(props:TextFieldProps){return <TextField {...props} autoComplete={props.autoComplete??'address-level2'}/>;}
export { AmountField,PostalAddress };
