# Wardo Design System

Wardo's web component library, built with React and TypeScript with source connections to the [Wardo DS Figma library](https://www.figma.com/design/rkJclvwYpmw9ja5vUwkl3P/Wardo-DS).

## Run the component preview

Use Node.js 22.12 or newer.

```sh
npm ci
npm run dev
```

Open the local address shown in the terminal. The preview includes theme switching, editable forms, selection controls, keyboard-operated navigation and disclosures. Open `/library` for the expanded gallery. Fonts are bundled locally in the preview; no third-party font requests are needed.

## App component coverage — incomplete

Only reusable components used inside apps are implementation and connection targets. This includes app controls, reusable compositions, their internal building blocks, and icons such as Lucide. Documentation, showcase/example screens, original UI-kit/device references, archives, and Apple Watch/watchOS are excluded. The policy is versioned in `coverage/scope.json`.

The audit retains 765 published records, but only **562 app components** count toward completion; **203 records are excluded references**. The default `/coverage` view shows app components. Excluded records remain available through the reference filter without implementation requirements or code examples.

There are **235 saved app source links**. The historical Figma records still contain **241 total saved links**, including **six example-screen connections scheduled for removal** in `coverage/connection-cleanup.json`. Figma editing remains deferred, so those links have not been removed or misreported as deleted. The 139 unsaved Lucide links and native activation also remain deferred.

Implementation and validation remain independent: 167 app records are implemented, 13 are verified, and 549 still require validation or implementation work. Existing example screens and native samples may remain development fixtures; they are not production component targets. No Apple Watch implementation is required.

Open `/coverage` for searchable records, platform alternatives, examples and explicit gaps, or run:

```sh
npm run coverage:lookup -- 1531:158362
npm run coverage:lookup -- 2277:12775 --platform Android
npm run coverage:check
npm run coverage:complete
```

The completion check deliberately fails until every active record has implementation, property mappings and verification evidence. See `coverage/WORK-IN-PROGRESS.md` and `native/README.md` for current work and reproducible native checks.

## What's included

The React library now includes navigation bars, sidebars, tabs, breadcrumbs, pagination, toolbars, menus and submenus, split buttons, FABs, segmented controls, autocomplete, selection lists, token fields, range sliders, steppers, date/time inputs, structured lists, sortable tables, expandable trees, carousels, grids, feedback notices, progress indicators, dialogs, sheets and tooltips, in addition to the original controls. `/library` opens the expanded interactive preview.

The 124 additional mappings in `figma/expanded-mappings.json` are saved in Figma. The next 54 web mappings are also saved in `figma/web-internals-mappings.json`, including the shared slider/range-slider adapter. Native SwiftUI and Compose sources are in `native`, with dedicated sample applications and native build/runtime checks. Full per-entry native validation remains in progress.

- 69 semantic colors across ten themes, eight control sizes and three conditions.
- Keyboard-operated composite controls and focus-managed overlays using React Aria.
- Eight icons exported from Figma artwork plus the original utility icons.
- Native form controls, reduced motion and left-to-right/right-to-left layout support.

Provider buttons expose callbacks for application integration. They do not perform authentication or payment themselves. Date and time pickers currently use the browser's native inputs. Source links and published property-aware snippets are tracked separately.

## Use in an application

The package is private and is not published to npm. For local use, install this repository as a file dependency or add it as a workspace package, build it, and import:

```tsx
import { Button, TextField, Accordion, WardoProvider } from '@wardo/design-system';
import '@wardo/design-system/styles.css';

export function Example() {
  return (
    <WardoProvider theme="wardo-light">
      <TextField label="Your name" autoComplete="name" />
      <Button hierarchy="primary">Continue</Button>
      <Accordion title="More information">Helpful details.</Accordion>
    </WardoProvider>
  );
}
```

Load Geologica and Source Serif 4 in your application. The preview uses the two `@fontsource-variable` packages. The component package supplies fallback font stacks but does not load fonts automatically.

Use `WardoProvider` so popovers and modal portals inherit the selected theme. Supported themes: `wardo-light`, `wardo-dark`, `ocean-light`, `ocean-dark`, `orchid-light`, `orchid-dark`, `ember-light`, `ember-dark`, `cloud-light`, or `cloud-dark`. Controls expose `size` and `condition` props. Use `dir="rtl"` on the component or an ancestor for right-to-left layouts.

Pass an accessible name (`aria-label`) to icon-only buttons. Use `selected` for a toggle button, `busy` during work, and `type="submit"` explicitly for submission. TextField, Checkbox, Switch, Select, RadioGroup, and Slider support native form behavior. Accordion supports both controlled `expanded` and uncontrolled `defaultExpanded`; groups support controlled `openItems` or uncontrolled `defaultOpenItems`.

## Figma connection

`figma/mappings.json` identifies each live Figma master and its implementation. **199 source links are saved in Figma Code Connect**: the original 21, the next 124 and 54 reusable internals and patterns. Figma's interface confirmed the connections, and connected-tool readback confirms the source references for the public masters and nested icons. The new 178 entries include explicit component/export names; most original entries are file-level. Desired names are recorded in the registries. The five property-aware templates are prepared and validated, but are not published. Figma's API rejected template writes with an Organization/Enterprise restriction; saving source links through the native Figma UI worked on the existing plan. See `figma/STATUS.md` for the verification and remaining limitation. GitHub integration is optional for manual source links. The Code Connect settings may still show “Connect to GitHub” until the repository browsing integration is authorized separately in Figma.

The five `.figma.ts` templates use Figma's parserless template API, exhaustive variant mappings, and dynamic instance swaps. Hover, pressed, and focus states belong to browser interaction; disabled state maps to the native button attribute. Component definitions and descendant anatomy used during setup are in `figma/context`.

To inspect templates locally:

```sh
npm run figma:check
npx figma connect parse --outFile /tmp/wardo-code-connect.json
```

To republish snippet templates later with the CLI, use your own Figma access token through the `FIGMA_ACCESS_TOKEN` environment variable, then run `npx figma connect publish`. Do not put tokens into files or commits. Source connections and property-aware template publication are separate operations.

## Native platforms

See [`native/README.md`](native/README.md) for the Apple and Android source packages and their current gaps. Figma Professional supports one active framework, so native activation must not silently replace React. Native build and runtime evidence is tracked per entry; complete cross-platform validation remains pending.

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

Native connection decision: the owner chose to keep React active and defer native connections. Native sources remain saved with their documented implementation and verification gaps.

## Example compositions

Open `/examples` for six mobile/desktop Upcoming, Reviews and Messaging reference screens with local artwork. Application callbacks and data can replace the fixture defaults. Example assets are a separate package entry:

```tsx
import { UpcomingMobileExample } from '@wardo/design-system/examples';
import '@wardo/design-system/examples.css';
```

The example stylesheet is emitted as `dist/design-system.css`; core styles remain available through `@wardo/design-system/styles.css`.

For RTL menus, configure the application locale through React Aria’s `I18nProvider` or `MenuButton`’s `locale` prop, and set the content direction with `dir`. Menu triggers support the shared hierarchy, tone, size and condition values, plus leading and trailing icon slots.

## App search components

`SearchField` supports `presentation="navigation"` for compact navigation chrome with an accessible hidden label, exact 20px source artwork, and native keyboard clearing/focus behavior. Set `dir` on the component to mirror the complete field. `/search-fields` provides its app-owned query, submit, disabled, theme and RTL examples.

Figma Sidebar Search Field `2396:18524` belongs to iOS/iPadOS and now resolves to `WardoSidebarSearchField`, independently of its historical React source link. It exposes application-owned query, submit and voice-search callbacks. Its iPhone/iPad samples and native review limitations are recorded in `coverage/evidence/2026-11-10/search-family-review.json`.
