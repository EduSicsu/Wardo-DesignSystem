# Wardo connection coverage

Rechecked in the native Figma Code Connect dialog on November 6, 2026: **21 of 797 connected**. That is 2.6% coverage and 776 unconnected published entries.

The original implementation stopped at 18 React component families and three icons. That was an implementation scope decision, not a Figma connection limit. It did not fulfill full-library coverage.

## What the remaining count means

Figma counts published component sets and standalone components, including internal building blocks and platform-specific assets. It does not mean there must be 797 separate React exports. Variants within a set are also distinct from these library entries.

The live dialog explicitly lists unconnected Android and Android XR toolbar internals, including toggleable icon buttons, FABs, focus indicators, and toolbar icons. These should not be pointed at an unrelated generic Button implementation solely to improve the counter.

## Current expansion

124 additional source mappings now have matching React implementations prepared. This expansion includes advanced inputs, navigation, data display, feedback, overlays, menus and five additional exported icons. See `expanded-mappings.json` for per-entry status. Prepared entries are not counted as connected until Figma confirms each save.

The expanded library passed 13 unit checks and 14 browser checks across desktop/mobile, including keyboard navigation, dialog focus, combo selection, table sorting, tree expansion, responsive width and automated WCAG checks in light and dark themes. This is behavioral validation, not a claim of complete visual parity with every platform variant.

Native iOS, Android, visionOS and XR components do not yet have corresponding native packages. Archived and prototype components must be accounted for separately. Five rich Code Connect templates are still unpublished because the API rejects template writes; the native source-link workflow remains available.

## Correct completion criteria

1. Inventory current public masters, internal components, platform components and legacy/archive entries with their IDs.
2. Match each eligible entry to an actual implementation, with component names and APIs that correspond to its purpose.
3. Build missing public component families, runtime behavior and meaningful accessibility checks.
4. Connect supported public masters and reusable internals to their matching code; explicitly account for native and retired entries.
5. Verify persisted source links, report implementation coverage separately from raw connection count, and distinguish source links from published templates.

No new connections were fabricated during this audit. Full-library coverage remains unfinished.

## Live inventory artifact

[INVENTORY.md](INVENTORY.md) lists the 677 on-canvas masters/component sets found across the six main component pages plus Iconset and Avatars. Of those, 21 match the existing connection registry and 656 do not. This scoped on-canvas count is separate from the published dialog count of 797; archive, toolbar-internal and other pages are not included. `component-inventory.json` contains IDs and machine-readable rows.
