import { render, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { expect, it } from 'vitest';
import { CoverageCatalogue } from '../demo/CoverageCatalogue';

it('does not present a historical React link as a native connection in the default view', async () => {
  const user = userEvent.setup();
  render(<CoverageCatalogue />);
  await user.type(screen.getByRole('searchbox', { name: 'Find a design or component' }), '2396:18524');
  expect(screen.getByRole('link', { name: 'WardoSidebarSearchField' })).toBeInTheDocument();
  expect(screen.queryByRole('region', { name: 'React implementation' })).not.toBeInTheDocument();
  expect(screen.getByText('A React source connection is saved separately for this design.')).toBeInTheDocument();
  expect(within(screen.getByRole('article')).getByText('not connected')).toBeInTheDocument();
});

it('shows the selected native implementation and keeps React connections separate', async () => {
  const user = userEvent.setup();
  render(<CoverageCatalogue />);
  const search = screen.getByRole('searchbox', { name: 'Find a design or component' });
  const platform = screen.getByRole('combobox', { name: 'Platform' });
  await user.type(search, '2277:12775');
  await user.selectOptions(platform, 'Android');
  expect(screen.getByRole('region', { name: 'Jetpack Compose implementation' })).toBeInTheDocument();
  expect(screen.queryByRole('region', { name: 'SwiftUI implementation' })).not.toBeInTheDocument();
  expect(within(screen.getByRole('region', { name: 'Jetpack Compose implementation' })).getByText(/Validation: pending/)).toBeInTheDocument();
  await user.clear(search);
  await user.type(search, '1159:29');
  await user.selectOptions(platform, 'iOS');
  expect(screen.getByRole('link', { name: 'wardoNavigationImage' })).toBeInTheDocument();
  expect(screen.queryByRole('region', { name: 'React implementation' })).not.toBeInTheDocument();
  expect(screen.getByText('A React source connection is saved separately for this design.')).toBeInTheDocument();
  expect(within(screen.getByRole('article')).getByText('not connected')).toBeInTheDocument();
  await user.selectOptions(screen.getByRole('combobox', { name: 'Coverage' }), 'validated');
  expect(screen.getByRole('article')).toBeInTheDocument();
  await user.clear(search);
  await user.type(search, '2277:12775');
  expect(screen.queryByRole('article')).not.toBeInTheDocument();
});
