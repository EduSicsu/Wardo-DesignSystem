'use client';
import { Slider, type SliderProps } from './Selection';
import { RangeSlider } from './AdvancedInputs';

export type SliderControlProps =
  | ({ kind: 'single' } & SliderProps)
  | ({ kind: 'range' } & Parameters<typeof RangeSlider>[0]);

/** Preserves scalar and endpoint value types when selecting the slider presentation. */
export function SliderControl(props: SliderControlProps) {
  if (props.kind === 'range') {
    const { kind, ...range } = props;
    return <RangeSlider {...range}/>;
  }
  const { kind, ...single } = props;
  return <Slider {...single}/>;
}
