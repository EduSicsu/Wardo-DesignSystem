// url=https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-25362
// source=src/components/Button.tsx
// component=Button
import figma from 'figma'
const instance = figma.selectedInstance
const hierarchy = instance.getEnum('Hierarchy', {"Primary": "primary", "Secondary": "secondary", "Tertiary": "tertiary", "Tonal": "tonal", "Text": "text"})
const tone = instance.getEnum('Tone', {"Default": "default", "Confirmation": "confirmation", "Warning": "warning", "Error": "error", "Neutral": "neutral"})
const state = instance.getEnum('State', {"Default": "default", "Hover": "hover", "Pressed": "pressed", "Focused": "focused", "Disabled": "disabled"})
const layoutdirection = instance.getEnum('Layout direction', {"LTR": "ltr", "RTL": "rtl"})
const label = instance.getString('Label')
const leading = instance.getBoolean('Show leading icon') ? instance.getInstanceSwap('Leading icon') : undefined
const trailing = instance.getBoolean('Show trailing icon') ? instance.getInstanceSwap('Trailing icon') : undefined
const leadingCode = leading && leading.type === 'INSTANCE' ? leading.executeTemplate().example : undefined
const trailingCode = trailing && trailing.type === 'INSTANCE' ? trailing.executeTemplate().example : undefined
const showLabel = instance.getBoolean('Show label')
const selected = instance.getBoolean('Selected')
// Hover, pressed and focus variants are handled by CSS and browser interaction.
export default { example: figma.code`<Button hierarchy="${hierarchy}" tone="${tone}" dir="${layoutdirection}" ${state === 'disabled' ? 'disabled' : ''} ${selected ? 'selected' : ''} ${leadingCode ? figma.code`leadingIcon={${leadingCode}}` : ''} ${trailingCode ? figma.code`trailingIcon={${trailingCode}}` : ''} ${!showLabel ? figma.code`aria-label=${JSON.stringify(label)}` : ''}>${showLabel ? figma.code`{${JSON.stringify(label)}}` : ''}</Button>`, imports: ['import { Button } from "@wardo/design-system"'], id: 'button', metadata: { nestable: true } }
