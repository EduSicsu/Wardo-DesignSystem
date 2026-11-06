import type { ButtonHTMLAttributes, ReactNode } from 'react';
import { cx, type Size, type Condition, type Hierarchy, type Tone } from './shared';
export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  hierarchy?: Hierarchy; tone?: Tone; size?: Size; condition?: Condition;
  leadingIcon?: ReactNode; trailingIcon?: ReactNode; busy?: boolean; selected?: boolean;
}
export function Button({ hierarchy='primary', tone='default', size='M', condition='normal', leadingIcon, trailingIcon, busy=false, selected, disabled, className, children, type='button', ...props }: ButtonProps) {
  return <button {...props} type={type} className={cx('wardo-button',className)} data-hierarchy={hierarchy} data-tone={tone} data-wardo-size={size} data-wardo-condition={condition} data-icon-only={!children || undefined} disabled={disabled || busy} aria-busy={busy || undefined} aria-pressed={selected}>
    {busy ? <span className="wardo-spinner" aria-hidden="true"/> : leadingIcon ? <span className="wardo-icon">{leadingIcon}</span> : null}
    {children ? <span>{children}</span> : null}{trailingIcon ? <span className="wardo-icon">{trailingIcon}</span> : null}
  </button>;
}
