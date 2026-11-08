# Wardo connection coverage

Last confirmed in Figma: **145 of 797 source connections saved** (18.2%), leaving 652 unconnected. The original 21 have been extended with 124 verified source links. Another 53 implementation-backed web mappings and nine initial native mappings are prepared, not yet saved.

## Complete published inventory

On November 7, 2026, every nonempty relevant page was queried, excluding variants inside component sets. Of 1,178 on-canvas masters/component sets, **797 are published** (`CURRENT` or `CHANGED`). This exactly matches the Code Connect dialog denominator. See `published-inventory.json`.

The published audit classification is:

| Category | Entries |
| --- | ---: |
| Runtime candidates, including native controls and reusable internals | 409 |
| Archived components | 44 |
| Documentation and organization assets | 174 |
| Device references and platform examples | 164 |
| Wardo example compositions | 6 |
| Total | 797 |

These are audit categories, not Figma connection or Skip statuses. No entry has been marked skipped merely by writing this report. Device bezels, system keyboards and documentation illustrations should not be presented as ordinary application components.

## Implementations and checks

The React library covers actions, advanced inputs, navigation, data display, menus, feedback, overlays and recovery/form patterns. Meaningful checks cover keyboard navigation, focus restoration, combo selection, chip ordering, table sorting, tree expansion, responsive width and automated light/dark WCAG checks.

Native SwiftUI and Jetpack Compose source packages, semantic color snapshots and licensed fonts are in `native`. Native builds and runtime checks were explicitly deferred by the owner. Several custom visionOS layouts and Android XR spatial behavior still require implementation and validation; generic system pickers are not claimed as full visual matches.

## Activation and snippets

Figma Professional permits one active framework. React remains active. SwiftUI and Compose cannot all be active alongside React on that plan; see [Figma's framework documentation](https://developers.figma.com/docs/code-connect/code-connect-ui-setup/#connecting-one-component-to-multiple-frameworks). No billing or framework settings have been changed.

Five property-aware templates remain unpublished because API writes reject access. Saved source links are separate from published Inspect snippets. Current per-entry source states are recorded in `expanded-mappings.json`, `web-internals-mappings.json` and `native-mappings.json`.
