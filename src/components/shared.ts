export type Size = 'XS' | 'S' | 'M' | 'L' | 'XL' | '2XL' | 'Chonky' | 'Hero';
export type Condition = 'normal' | 'serious' | 'chonky';
export type Hierarchy = 'primary' | 'secondary' | 'tertiary' | 'tonal' | 'text';
export type Tone = 'default' | 'confirmation' | 'warning' | 'error' | 'neutral';
export const cx = (...classes: (string | undefined | false)[]) => classes.filter(Boolean).join(' ');
