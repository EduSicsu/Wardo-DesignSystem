import { Button, type ButtonProps } from './Button';
import { cx } from './shared';
export function ActionChip({hierarchy='tonal', className, ...props}: ButtonProps) {
  return <Button {...props} hierarchy={hierarchy} className={cx('wardo-chip',className)}/>;
}
