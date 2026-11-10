import type { HTMLAttributes } from 'react';
export interface NotificationScrimProps extends Omit<HTMLAttributes<HTMLDivElement>,'children'> { mode?: 'light'|'dark'; }
/** Decorative notification backdrop; the owning overlay handles dismissal and focus. */
export function NotificationScrim({className,mode='light',style,...props}:NotificationScrimProps){
 return <div {...props} data-mode={mode} aria-hidden="true" className={['wardo-notification-scrim',className].filter(Boolean).join(' ')} style={{position:'absolute',inset:0,pointerEvents:'none',backgroundImage:'linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05)),linear-gradient(rgba(0,0,0,.25),rgba(0,0,0,.25))',...style}}/>;
}
