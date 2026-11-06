# Figma connection status

Prepared on November 6, 2026. **Connections are not active in Figma yet.**

The code is available on the repository's `main` branch. `mappings.json` contains 18 component source links and three icon links. Five parserless templates are checked and ready to publish.

## Activation blocker

Both `send_code_connect_mappings` and a single `add_code_connect_map` call were rejected by Figma with: “Code connections can only be made in libraries that are in Organization or Enterprise plans.”

The connected Figma account has Full seats on Starter and Professional teams. Figma's current [Code Connect UI documentation](https://developers.figma.com/docs/code-connect/code-connect-ui-setup/) lists Professional support (one active library/framework), so this could be a file eligibility, rollout, or API limitation. Do not purchase an upgrade based solely on this error.

The native Figma interface could not be inspected because the Mac was locked. The alternative in-app browser opened a Figma login screen. No plan, account permissions, library location, or billing settings were changed.

Figma diagnostic references:

- Bulk connection: `216ce5cd-c240-4984-8990-9a708ac60971`
- Individual Accordion connection: `7bf088ad-aaa3-4063-a2e7-f03be98651c0`

## Finish in Figma

1. Open Wardo DS in the signed-in Figma application.
2. Open Dev Mode → Library → Connect components to code.
3. Try the Accordion mapping first using the source URL below. GitHub authorization is optional for manual links.
4. If the interface permits it, add the remaining entries from the source-link table. If it shows the same plan restriction, resolve eligibility with Figma support using the diagnostic references above.
5. Publish the five `.figma.ts` templates with Code Connect CLI or the connected tools after access is available.

Source-file mappings give agents implementation references. Template publication additionally supplies property-aware snippets for Button, ActionChip, and the three icons.

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
