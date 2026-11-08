'use client';
import { useId, type HTMLAttributes, type ReactNode, type Ref } from 'react';
import { Button } from './Button';
import { Notification, ProgressIndicator } from './Feedback';
import { cx } from './shared';

export interface FormError { fieldId: string; message: string; }
export function FormErrorSummary({ errors, title = 'There is a problem', instructions = 'Check the following fields before continuing.', ref, ...props }: Omit<HTMLAttributes<HTMLDivElement>, 'title'> & { errors: FormError[]; title?: string; instructions?: string; ref?: Ref<HTMLDivElement> }) {
  const heading = useId();
  if (!errors.length) return null;
  return <div {...props} ref={ref} role="alert" tabIndex={-1} aria-labelledby={heading} className={cx('wardo-form-errors', props.className)}>
    <h2 id={heading}>{title}</h2><p>{instructions}</p>
    <ul>{errors.map(error => <li key={error.fieldId}><a href={`#${encodeURIComponent(error.fieldId)}`} onClick={event => {
      const field = document.getElementById(error.fieldId);
      if (field) { event.preventDefault(); field.focus(); field.scrollIntoView?.({ block: 'center' }); }
    }}>{error.message}</a></li>)}</ul>
  </div>;
}

export type RecoveryScenario = 'first-use' | 'no-results' | 'error' | 'offline' | 'partial-failure' | 'refreshing' | 'long-running';
const defaults: Record<RecoveryScenario, { title: string; description: string }> = {
  'first-use': { title: 'No items yet', description: 'Add your first photos to create a collection.' },
  'no-results': { title: 'No matching collections', description: 'Try another search or remove a filter.' },
  error: { title: "Couldn’t load this collection", description: 'Try loading the collection again.' },
  offline: { title: "You’re offline", description: 'Saved content remains available. Changes will sync when you reconnect.' },
  'partial-failure': { title: 'Some photos could not sync', description: 'Your saved photos remain available. Retry the failed items.' },
  refreshing: { title: 'Checking for updates', description: 'Showing saved content while we check for changes.' },
  'long-running': { title: 'Uploading collection', description: 'You can cancel this upload.' },
};
export interface RecoveryAction { label: string; onAction: () => void; disabled?: boolean; }
export function Recovery({ scenario, title, description, children, primaryAction, secondaryAction, progress, ...props }: Omit<HTMLAttributes<HTMLDivElement>, 'title'> & { scenario: RecoveryScenario; title?: string; description?: string; children?: ReactNode; primaryAction?: RecoveryAction; secondaryAction?: RecoveryAction; progress?: number }) {
  const heading = useId();
  const copy = defaults[scenario];
  const notice = ['offline', 'partial-failure', 'refreshing'].includes(scenario);
  return <div {...props} className={cx('wardo-recovery', props.className)} data-scenario={scenario} aria-labelledby={heading}>
    {notice ? <Notification tone={scenario === 'refreshing' ? 'info' : 'warning'} title={<span id={heading}>{title ?? copy.title}</span>}>{description ?? copy.description}</Notification> : <><h2 id={heading}>{title ?? copy.title}</h2><p>{description ?? copy.description}</p></>}
    {children}
    {scenario === 'long-running' ? <ProgressIndicator label="Upload progress" value={progress} /> : null}
    <div className="wardo-recovery-actions">
      {primaryAction ? <Button onClick={primaryAction.onAction} disabled={primaryAction.disabled}>{primaryAction.label}</Button> : null}
      {secondaryAction ? <Button hierarchy="secondary" onClick={secondaryAction.onAction} disabled={secondaryAction.disabled}>{secondaryAction.label}</Button> : null}
    </div>
  </div>;
}
