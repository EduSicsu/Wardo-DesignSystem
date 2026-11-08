import { useState } from 'react';
import { FormErrorSummary, Recovery, ReorderableTokenField, SelectableChipGroup, CollapsibleChipGroup, FilterChip, TextField } from '../src';

export function PatternExamples() {
  const [keys, setKeys] = useState<string[]>(['design']);
  const [tokens, setTokens] = useState(['Alpha', 'Beta', 'Gamma']);
  const [cancelled, setCancelled] = useState(false);
  return <section id="patterns"><h2>Form and recovery patterns</h2>
    <TextField id="pattern-email" label="Contact email" error="Enter a valid email address."/>
    <FormErrorSummary errors={[{fieldId:'pattern-email',message:'Enter a valid contact email.'}]}/>
    <Recovery scenario={cancelled ? 'first-use' : 'long-running'} progress={42} primaryAction={cancelled ? undefined : {label:'Cancel example upload',onAction:()=>setCancelled(true)}}/>
    <SelectableChipGroup label="Selected disciplines" items={[{id:'design',label:'Design selection'},{id:'engineering',label:'Engineering selection'}]} selectedKeys={keys} onSelectionChange={setKeys}/>
    <CollapsibleChipGroup label="More filters" more={<FilterChip>Archived</FilterChip>}><FilterChip>Active</FilterChip></CollapsibleChipGroup>
    <ReorderableTokenField label="Ordered tags" tokens={tokens} onTokensChange={setTokens}/>
  </section>;
}
