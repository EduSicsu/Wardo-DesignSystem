# Wardo connection coverage

Rechecked in the native Figma Code Connect dialog on November 6, 2026: **21 of 797 connected**. That is 2.6% coverage and 776 unconnected published entries.

The original implementation stopped at 18 React component families and three icons. That was an implementation scope decision, not a Figma connection limit. It did not fulfill full-library coverage.

## What the remaining count means

Figma counts published component sets and standalone components, including internal building blocks and platform-specific assets. It does not mean there must be 797 separate React exports. Variants within a set are also distinct from these library entries.

The live dialog explicitly lists unconnected Android and Android XR toolbar internals, including toggleable icon buttons, FABs, focus indicators, and toolbar icons. These should not be pointed at an unrelated generic Button implementation solely to improve the counter.

## Gaps against the current code

- Actions: button groups, split buttons, FABs and FAB menus, menu actions/patterns, and provider sign-in/payment controls.
- Inputs: segmented controls, toggles, selection lists, value pickers, autocomplete, token fields, filter/input chips, range sliders, steppers, date pickers, and newer composed data inputs.
- Navigation: navigation bars, toolbars, tabs, sidebars and related building blocks.
- Content: structured lists and accessories, list headers/footers, carousels, tables, trees, code snippets, indexes, grids and text lists.
- Feedback/status and overlays: implementations are absent from the current React package.
- Assets: only three icons are connected; the full icon and avatar systems are not implemented.
- Native iOS, Android, visionOS and XR components: no matching native code packages have been built.
- Existing 21 source links: most are file-level, and the five richer templates are still unpublished.

## Correct completion criteria

1. Inventory current public masters, internal components, platform components and legacy/archive entries with their IDs.
2. Match each eligible entry to an actual implementation, with component names and APIs that correspond to its purpose.
3. Build missing public component families, runtime behavior and meaningful accessibility checks.
4. Connect supported public masters and reusable internals to their matching code; explicitly account for native and retired entries.
5. Verify persisted source links, report implementation coverage separately from raw connection count, and distinguish source links from published templates.

No new connections were fabricated during this audit. Full-library coverage remains unfinished.

## Live inventory artifact

[INVENTORY.md](INVENTORY.md) lists the 677 on-canvas masters/component sets found across the six main component pages plus Iconset and Avatars. Of those, 21 match the existing connection registry and 656 do not. This scoped on-canvas count is separate from the published dialog count of 797; archive, toolbar-internal and other pages are not included. `component-inventory.json` contains IDs and machine-readable rows.
