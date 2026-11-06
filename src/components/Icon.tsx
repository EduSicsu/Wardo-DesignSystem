import type { SVGProps } from 'react';
export type IconName = 'plus' | 'arrow-right' | 'bookmark' | 'chevron-down' | 'check' | 'close' | 'search' | 'eye' | 'eye-off';
const paths: Record<IconName, string> = {
  plus: 'M12 5v14M5 12h14', 'arrow-right':'M5 12h14m-7-7 7 7-7 7',
  bookmark:'M6 3h12v18l-6-4-6 4V3Z', 'chevron-down':'m6 9 6 6 6-6',
  check:'m5 12 4 4L19 6', close:'m6 6 12 12M6 18 18 6',
  search:'M21 21l-5-5M18 10a8 8 0 1 1-16 0 8 8 0 0 1 16 0',
  eye:'M2 12s3-7 10-7 10 7 10 7-3 7-10 7S2 12 2 12Zm13 0a3 3 0 1 1-6 0 3 3 0 0 1 6 0',
  'eye-off':'m3 3 18 18M10 5c7-1 12 7 12 7a18 18 0 0 1-4 4M6 6a19 19 0 0 0-4 6s3 7 10 7a12 12 0 0 0 5-1M10 10a3 3 0 0 0 4 4'
};
export function Icon({ name, ...props }: SVGProps<SVGSVGElement> & { name: IconName }) {
  return <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true" focusable="false" {...props}><path d={paths[name]}/></svg>;
}
