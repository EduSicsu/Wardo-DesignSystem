# Current Figma connection status

**198 of 797 source links saved**, confirmed in the native UI. The newest 177 entries were saved with explicit component names. `expanded-mappings.json` and `web-internals-mappings.json` record those saves. The complete published inventory matches all 797 entries, including documentation, archives and device references.

One further shared slider adapter is prepared. Nine first native source links are blocked by the framework plan. The native Alert save optimistically increased the count to 199, then rolled back to 198 with “Code Connect is set up for React. Upgrade your plan for more frameworks.” It is not counted as saved. Native builds were deferred by the owner. React remains the active framework; the Professional plan supports one active framework. Other native implementation and visual gaps are documented in `native/README.md`.

The historical initial verification below remains useful for the original 21 entries and the unpublished template limitation.

# Original source-link verification

**21 source links saved in Figma Code Connect on November 6, 2026.**

The native Figma interface showed `21 of 797 connected` after saving the 18 implemented component families and three action icons. The other 776 published library components are outside this initial web release and were not connected to unsupported implementations.

## Verification

- Each source entry was submitted through the Code Connect interface. Figma displayed successful connection states and incremented the connected count.
- The Connected filter showed the saved repository URLs for Accordion, Accordion Group, Action Chip, the icons, Button, Checkbox, Content Card, Divider, and Link.
- Remote `get_code_connect_map` readback confirmed the expected source files across 17 public component masters, including NumberField. Nested icon instances resolve to `Icon.tsx`.
- ActionChip's source connection was confirmed by the native UI save and count, but its master and older documentation samples returned no mappings through the readback tool. It has no nested implementation wrapper; that empty response does not establish a missing UI connection.
- Most connections are file-level (the optional component/export name is absent in remote readback). Desired export names are recorded in `mappings.json`; Accordion has its explicit export name saved. Files with multiple exports remain linked to their source implementation.
- The Mac locked again during optional detail editing. No reload was performed because Figma also displayed an unsynced canvas-changes banner. The remote readback confirms that source connections persisted independently of that canvas banner.

## Remaining limitation: rich snippets

Five parserless templates are prepared and locally validated: Button, ActionChip, plus, arrow-right, and chevron-down. They are **not published** and `hasTemplate` remains false in remote readback. Source references and property-aware Inspect snippets are separate features.

Both bulk and individual API writes were rejected with an Organization/Enterprise plan restriction. The native interface allowed source connections on the existing plan. No billing, permissions, library location, or account settings were changed; no upgrade was purchased. Figma's [current documentation](https://developers.figma.com/docs/code-connect/code-connect-ui-setup/) lists Professional support.

API diagnostic references, retained for future template publication troubleshooting:

- Bulk connection: `216ce5cd-c240-4984-8990-9a708ac60971`
- Individual Accordion connection: `7bf088ad-aaa3-4063-a2e7-f03be98651c0`

`ready-to-connect.json` is a prepared API publication payload, not evidence that its templates have been published. Do not replay it blindly over the existing source mappings. The CLI files can be published after template access is available.

## Source links

| Figma component | Code component | Source |
| --- | --- | --- |
| [Button](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-25362) | `Button` | [src/components/Button.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Button.tsx) |
| [ActionChip](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-20475) | `ActionChip` | [src/components/ActionChip.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/ActionChip.tsx) |
| [Accordion](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=2601-7933) | `Accordion` | [src/components/Accordion.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Accordion.tsx) |
| [AccordionGroup](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=2886-32415) | `AccordionGroup` | [src/components/Accordion.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Accordion.tsx) |
| [TextField](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-153013) | `TextField` | [src/components/TextField.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/TextField.tsx) |
| [TextArea](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-154760) | `TextArea` | [src/components/TextField.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/TextField.tsx) |
| [PasswordField](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-156521) | `PasswordField` | [src/components/TextField.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/TextField.tsx) |
| [SearchField](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-158362) | `SearchField` | [src/components/TextField.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/TextField.tsx) |
| [NumberField](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-160340) | `NumberField` | [src/components/TextField.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/TextField.tsx) |
| [Select](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-166415) | `Select` | [src/components/TextField.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/TextField.tsx) |
| [Checkbox](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-161900) | `Checkbox` | [src/components/Selection.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Selection.tsx) |
| [Switch](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-163992) | `Switch` | [src/components/Selection.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Selection.tsx) |
| [RadioGroup](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-162601) | `RadioGroup` | [src/components/Selection.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Selection.tsx) |
| [Slider](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-176245) | `Slider` | [src/components/Selection.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Selection.tsx) |
| [ContentCard](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=2601-7762) | `ContentCard` | [src/components/Content.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Content.tsx) |
| [MetadataTag](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=2601-7659) | `MetadataTag` | [src/components/Content.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Content.tsx) |
| [Divider](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=2598-7033) | `Divider` | [src/components/Content.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Content.tsx) |
| [Link](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=1531-24320) | `Link` | [src/components/Content.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Content.tsx) |
| [Icon](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=906-5837) | `Icon` | [src/components/Icon.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Icon.tsx) |
| [Icon](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=906-5839) | `Icon` | [src/components/Icon.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Icon.tsx) |
| [Icon](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS?node-id=906-5841) | `Icon` | [src/components/Icon.tsx](https://github.com/EduSicsu/Wardo-DesignSystem/blob/main/src/components/Icon.tsx) |
