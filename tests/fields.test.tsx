import { useState } from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, it, vi } from 'vitest';
import { SearchField, Select } from '../src';

describe('search field clearing',()=>{
 it('updates controlled application state and returns focus to search',async()=>{
  const user=userEvent.setup();const cleared=vi.fn();
  function Search(){const [value,setValue]=useState('Ceramics');return <><SearchField label="Find events" value={value} onChange={event=>setValue(event.target.value)} onClear={cleared}/><output aria-label="Search value">{value||'Empty'}</output></>;}
  render(<Search/>);await user.click(screen.getByRole('button',{name:'Clear search'}));
  expect(screen.getByRole('searchbox')).toHaveValue('');expect(screen.getByLabelText('Search value')).toHaveTextContent('Empty');expect(screen.getByRole('searchbox')).toHaveFocus();expect(cleared).toHaveBeenCalledOnce();expect(screen.queryByRole('button',{name:'Clear search'})).not.toBeInTheDocument();
  await user.type(screen.getByRole('searchbox'),'Books');expect(screen.getByLabelText('Search value')).toHaveTextContent('Books');
 });
 it('clears an uncontrolled value and keeps read-only fields unchanged',async()=>{
  const user=userEvent.setup();render(<><SearchField label="Editable" defaultValue="Events"/><SearchField label="Read only" value="Saved" readOnly/></>);
  expect(screen.getAllByRole('button',{name:'Clear search'})).toHaveLength(1);await user.click(screen.getByRole('button',{name:'Clear search'}));expect(screen.getByLabelText('Editable')).toHaveValue('');expect(screen.getByLabelText('Read only')).toHaveValue('Saved');
 });
 it('does not clear a disabled field',async()=>{render(<SearchField label="Search" defaultValue="Saved" disabled/>);expect(screen.getByRole('button',{name:'Clear search'})).toBeDisabled();});
});
it('retains native select labeling, form submission, and change events',async()=>{
 const user=userEvent.setup();const changed=vi.fn();render(<form aria-label="Preferences"><Select label="Workspace" name="workspace" defaultValue="personal" onChange={changed}><option value="personal">Personal</option><option value="team">Team</option></Select></form>);
 await user.selectOptions(screen.getByRole('combobox',{name:'Workspace'}),'team');expect(changed).toHaveBeenCalledOnce();expect(new FormData(screen.getByRole('form') as HTMLFormElement).get('workspace')).toBe('team');
});
