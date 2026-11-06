// url=https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-20475
// source=src/components/ActionChip.tsx
// component=ActionChip
import figma from 'figma'
const instance = figma.selectedInstance
const hierarchy = instance.getEnum('Hierarchy', {"Tonal": "tonal", "Text": "text", "Primary": "primary", "Secondary": "secondary", "Tertiary": "tertiary"})
const tone = instance.getEnum('Tone', {"Default": "default", "Confirmation": "confirmation", "Warning": "warning", "Error": "error"})
const state = instance.getEnum('State', {"Default": "default", "Hover": "hover", "Pressed": "pressed", "Focused": "focused", "Disabled": "disabled"})
const layoutdirection = instance.getEnum('Layout direction', {"LTR": "ltr", "RTL": "rtl"})
const label = instance.getString('Label')
const leading = instance.getBoolean('Show leading icon') ? instance.getInstanceSwap('Leading icon') : undefined
const trailing = instance.getBoolean('Show trailing icon') ? instance.getInstanceSwap('Trailing icon') : undefined
const leadingCode = leading && leading.type === 'INSTANCE' ? leading.executeTemplate().example : undefined
const trailingCode = trailing && trailing.type === 'INSTANCE' ? trailing.executeTemplate().example : undefined
const busy = instance.getEnum('Busy', {"False": false, "True": true})
// Hover, pressed and focus variants are handled by CSS and browser interaction.
export default { example: figma.code`<ActionChip hierarchy="${hierarchy}" tone="${tone}" dir="${layoutdirection}" ${state === 'disabled' ? 'disabled' : ''} ${busy ? 'busy' : ''} ${leadingCode ? figma.code`leadingIcon={${leadingCode}}` : ''} ${trailingCode ? figma.code`trailingIcon={${trailingCode}}` : ''}>{${JSON.stringify(label)}}</ActionChip>`, imports: ['import { ActionChip } from "@wardo/design-system"'], id: 'actionchip', metadata: { nestable: true } }
