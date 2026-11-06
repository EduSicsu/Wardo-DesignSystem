# Wardo Design System

Wardo's web component library, built with React and TypeScript with source connections to the [Wardo DS Figma library](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS).

## Run the component preview

Use Node.js 22.12 or newer.

```sh
npm ci
npm run dev
```

Open the local address shown in the terminal. The preview includes theme switching, button states, editable forms, selection controls, and keyboard-operated disclosures. Fonts are bundled locally in the preview; no third-party font requests are needed.

## What's included

- 18 component connections: Button, ActionChip, Accordion, AccordionGroup, TextField, TextArea, PasswordField, SearchField, NumberField, Select, Checkbox, Switch, RadioGroup, Slider, ContentCard, MetadataTag, Divider, and Link.
- Icon helper with a small set of web icons. This is not a full export of Wardo's Figma icon library.
- 69 semantic colors exported from live Figma variables across Wardo, Ocean, Orchid, Ember, and Cloud, each in light and dark.
- Eight Figma control sizes and three conditions: Normal, Serious, and Chonky.
- Geologica for headings/actions and Source Serif 4 for body text.
- Native form inputs and keyboard behavior, accessible names and descriptions, validation associations, focus indicators, reduced-motion support, and single/multiple accordion expansion.
- Full Code Connect templates for Button, ActionChip, plus, arrow-right, and chevron-down icons; source-file mappings for the remaining components.

This is the initial web library. Figma's native iOS, Android, visionOS, toolbar, menu, calendar, table, tree, and other advanced families are not implemented in this release. Mapping a component to source is distinct from publishing a property-aware snippet. The registry explicitly distinguishes the two.

## Use in an application

The package is private and is not published to npm. For local use, install this repository as a file dependency or add it as a workspace package, build it, and import:

```tsx
import { Button, TextField, Accordion } from '@wardo/design-system';
import '@wardo/design-system/styles.css';

export function Example() {
  return (
    <div data-wardo-theme="wardo-light">
      <TextField label="Your name" autoComplete="name" />
      <Button hierarchy="primary">Continue</Button>
      <Accordion title="More information">Helpful details.</Accordion>
    </div>
  );
}
```

Load Geologica and Source Serif 4 in your application. The preview uses the two `@fontsource-variable` packages. The component package supplies fallback font stacks but does not load fonts automatically.

Set `data-wardo-theme` on an ancestor: `wardo-light`, `wardo-dark`, `ocean-light`, `ocean-dark`, `orchid-light`, `orchid-dark`, `ember-light`, `ember-dark`, `cloud-light`, or `cloud-dark`. Controls expose `size` and `condition` props. Use `dir="rtl"` on the component or an ancestor for right-to-left layouts.

Pass an accessible name (`aria-label`) to icon-only buttons. Use `selected` for a toggle button, `busy` during work, and `type="submit"` explicitly for submission. TextField, Checkbox, Switch, Select, RadioGroup, and Slider support native form behavior. Accordion supports both controlled `expanded` and uncontrolled `defaultExpanded`; groups support controlled `openItems` or uncontrolled `defaultOpenItems`.

## Figma connection

`figma/mappings.json` identifies each live Figma master and its implementation. **All 21 source links are saved in Figma Code Connect**: the 18 component families and three icons. Figma's interface confirmed the connections, and connected-tool readback confirms the source references for the public masters and nested icons. Most are file-level connections; the desired export names are also recorded in the registry. The five property-aware templates are prepared and validated, but are not published. Figma's API rejected template writes with an Organization/Enterprise restriction; saving source links through the native Figma UI worked on the existing plan. See `figma/STATUS.md` for the verification and remaining limitation. GitHub integration is optional for manual source links. The Code Connect settings may still show “Connect to GitHub” until the repository browsing integration is authorized separately in Figma.

The two `.figma.ts` templates use Figma's parserless template API, exhaustive variant mappings, and dynamic instance swaps. Hover, pressed, and focus states belong to browser interaction; disabled state maps to the native button attribute. Component definitions and descendant anatomy used during setup are in `figma/context`.

To inspect templates locally:

```sh
npm run figma:check
npx figma connect parse --outFile /tmp/wardo-code-connect.json
```

To republish snippet templates later with the CLI, use your own Figma access token through the `FIGMA_ACCESS_TOKEN` environment variable, then run `npx figma connect publish`. Do not put tokens into files or commits. Source connections and property-aware template publication are separate operations.

## Tokens and maintenance

`tokens/colors.figma.json` and `tokens/controls.figma.json` record the exported Figma values from November 6, 2026. `npm run tokens` generates `src/styles/tokens.css` and the combined stylesheet. The generator validates every color and resolves alias opacity. It adds web-only readable foreground aliases where an original foreground/background pair falls below 4.5:1; the original Figma token values remain unchanged.

These files are snapshots; changing Figma does not automatically update this repository. Re-export, regenerate, and run checks after design changes.

## Verify and build

```sh
npm run check
npm run figma:check
npx playwright install chromium
npm run test:e2e
```

The library build emits JavaScript, TypeScript declarations, and `dist/styles.css`. `npm run build:demo` produces the standalone preview in `demo-dist`. GitHub Actions runs the same checks. Automated accessibility checks complement manual screen-reader and cross-browser testing; they do not certify WCAG conformance.

No npm release, public website deployment, backend, or user data storage is configured.
