import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { expect, it, vi } from 'vitest';
import { NavigationItem } from '../src';

it('keeps the destination name and localized badge description separate',()=>{
 render(<><p id="extra">Opens the event list</p><NavigationItem id="events" label="Events" href="/events" current badge={0} badgeLabel="No unread events" aria-describedby="extra"/></>);
 const link=screen.getByRole('link',{name:'Events'});
 expect(link).toHaveAccessibleDescription('Opens the event list No unread events');
 expect(link).toHaveAttribute('aria-current','page');
 expect(link).toHaveAttribute('href','/events');
});
it('excludes disabled destinations from keyboard navigation and suppresses their callback',async()=>{
 const activate=vi.fn();render(<NavigationItem id="events" label="Events" href="/events" disabled onClick={activate}/>);
 const link=screen.getByRole('link',{name:'Events'});
 expect(link).not.toHaveAttribute('href');expect(link).toHaveAttribute('aria-disabled','true');
 await userEvent.tab();expect(link).not.toHaveFocus();await userEvent.click(link);expect(activate).not.toHaveBeenCalled();
});
