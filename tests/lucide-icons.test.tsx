import { createElement } from 'react';
import { renderToStaticMarkup } from 'react-dom/server';
import type { LucideIcon } from 'lucide-react';
import { expect, it } from 'vitest';
import * as icons from '../src/components/LucideIcons';
import manifest from '../coverage/lucide-icons.json';

it('renders every catalogued Lucide export as nonempty, decorative 24-point artwork', () => {
  const exports = icons as Record<string, LucideIcon>;
  expect(manifest.icons).toHaveLength(153);
  for (const record of manifest.icons) {
    const host = document.createElement('div');
    host.innerHTML = renderToStaticMarkup(createElement(exports[record.symbol], { 'aria-hidden': true }));
    const svg = host.querySelector('svg');
    expect(svg, record.name).not.toBeNull();
    expect(svg).toHaveAttribute('width', '24');
    expect(svg).toHaveAttribute('height', '24');
    expect(svg).toHaveAttribute('viewBox', '0 0 24 24');
    expect(svg).toHaveAttribute('aria-hidden', 'true');
    expect(svg?.querySelector('path,line,rect,circle,polyline,polygon,ellipse'), record.name).not.toBeNull();
  }
});

it('preserves application-supplied size, color, stroke, and accessible naming', () => {
  const host = document.createElement('div');
  host.innerHTML = renderToStaticMarkup(createElement(icons.Balloon, {
    size: 48, color: '#123456', strokeWidth: 1.5,
    role: 'img', 'aria-label': 'Celebration', 'aria-hidden': false,
  }));
  const svg = host.querySelector('svg');
  expect(svg).toHaveAttribute('width', '48');
  expect(svg).toHaveAttribute('height', '48');
  expect(svg).toHaveAttribute('stroke', '#123456');
  expect(svg).toHaveAttribute('stroke-width', '1.5');
  expect(svg).toHaveAttribute('role', 'img');
  expect(svg).toHaveAttribute('aria-label', 'Celebration');
  expect(svg).toHaveAttribute('aria-hidden', 'false');
});
