'use client';
import { useId, useRef, useState, type ReactNode } from 'react';
import { FilterChip, ChipGroup, TokenField, type Choice } from './AdvancedInputs';
import { Button } from './Button';

export function SelectableChipGroup({ label, items, selectedKeys, onSelectionChange, multiple = false }: { label: string; items: Choice[]; selectedKeys: string[]; onSelectionChange: (keys: string[]) => void; multiple?: boolean }) {
  return <ChipGroup label={label}>{items.map(item => <FilterChip key={item.id} selected={selectedKeys.includes(item.id)} disabled={item.disabled} onSelectedChange={selected => onSelectionChange(multiple ? selected ? [...selectedKeys, item.id] : selectedKeys.filter(key => key !== item.id) : selected ? [item.id] : [])}>{item.label}</FilterChip>)}</ChipGroup>;
}

export function CollapsibleChipGroup({ label, children, more, moreLabel = 'Show all', lessLabel = 'Show fewer' }: { label: string; children: ReactNode; more: ReactNode; moreLabel?: string; lessLabel?: string }) {
  const [expanded, setExpanded] = useState(false); const id = useId();
  return <div><ChipGroup label={label}>{children}<span id={id} hidden={!expanded}>{more}</span><Button hierarchy="text" size="S" aria-expanded={expanded} aria-controls={id} onClick={() => setExpanded(value => !value)}>{expanded ? lessLabel : moreLabel}</Button></ChipGroup></div>;
}

export function ReorderableTokenField({ label, tokens, onTokensChange, disabled = false }: { label: string; tokens: string[]; onTokensChange: (tokens: string[]) => void; disabled?: boolean }) {
  const root = useRef<HTMLDivElement>(null); const [message, setMessage] = useState('');
  const move = (index: number, direction: -1 | 1) => {
    const target = index + direction; if (target < 0 || target >= tokens.length) return;
    const next = [...tokens]; [next[index], next[target]] = [next[target], next[index]];
    onTokensChange(next); setMessage(`${tokens[index]} moved to position ${target + 1} of ${tokens.length}`);
    requestAnimationFrame(() => root.current?.querySelectorAll<HTMLButtonElement>(`[data-move="${direction}"]`)[target]?.focus());
  };
  return <div ref={root}><TokenField label={label} tokens={tokens} onTokensChange={onTokensChange} disabled={disabled}/>
    <ol className="wardo-token-order" aria-label={`${label} order`}>{tokens.map((token, index) => <li key={token}><span>{token}</span><Button size="XS" hierarchy="text" data-move={-1} aria-label={`Move ${token} earlier`} disabled={disabled || index === 0} onClick={() => move(index, -1)}>Earlier</Button><Button size="XS" hierarchy="text" data-move={1} aria-label={`Move ${token} later`} disabled={disabled || index === tokens.length - 1} onClick={() => move(index, 1)}>Later</Button></li>)}</ol>
    <span role="status" className="wardo-visually-hidden">{message}</span>
  </div>;
}
