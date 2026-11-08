import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, it, vi } from 'vitest';
import { FormErrorSummary, Recovery } from '../src';

describe('recovery and error navigation', () => {
  it('moves focus from a summary link to the failing field', async () => {
    const user = userEvent.setup();
    render(<><label htmlFor="email">Email</label><input id="email" /><FormErrorSummary errors={[{fieldId:'email',message:'Enter a valid email.'}]} /></>);
    await user.click(screen.getByRole('link',{name:'Enter a valid email.'}));
    expect(screen.getByLabelText('Email')).toHaveFocus();
  });
  it('leaves retry and cancellation in the application’s control', async () => {
    const cancel = vi.fn(); const user = userEvent.setup();
    render(<Recovery scenario="long-running" progress={30} primaryAction={{label:'Cancel upload',onAction:cancel}} />);
    expect(screen.getByRole('progressbar')).toHaveAttribute('value','30');
    await user.click(screen.getByRole('button',{name:'Cancel upload'}));
    expect(cancel).toHaveBeenCalledOnce();
  });
});
