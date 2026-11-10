# Independent coverage registry

`registry.json` is generated from the versioned published inventory, excluding the 33 archived published masters removed at the owner’s request. It currently contains 765 records: the original 797 entries minus 33 archived masters, plus sidebar icon 3399:29565 from the versioned 2026-11-09 snapshot. `figma-archive-cleanup.json` preserves the exact removal audit and remaining active-design dependencies; the original inventory is retained for reconciliation. Two additional unpublished archived prototypes were also removed. Stable identifiers are `wardo-<node-id-with-hyphens>`. `implementations.json` contains reviewed overrides; `scripts/build-coverage.mjs` deterministically merges them with the published inventory and existing connections. Regenerate with `npm run coverage:build`.

Implementation, property review, validation, and Figma connection state are independent. `source-available` indicates a candidate implementation, never a verified match. `alternatives` records other platform implementations of the same design. `gaps` lists unfinished implementation or review work. Archives, documentation, and device references include explicit dispositions and Figma links.

Lookup supports node IDs, stable IDs, exact design names, source symbols, or Figma URLs:

```sh
npm run coverage:lookup -- 2277:12775 --platform Android
npm run coverage:summary
npm run coverage:check
npm run coverage:complete
```

`coverage:check` checks inventory membership and duplicates, stable IDs, repository-relative source paths, source symbols, asset integrity, reference dispositions, and the requirements of any verified record. `coverage:complete` additionally rejects every unfinished active record. It is expected to fail during implementation.

Verification evidence must name real repository files, describe the tested platform/configuration and variants, and refer to the source revision or hashes it exercised. Build success alone cannot verify design fidelity or accessibility. Screenshots are previews until reviewed against the design and must not silently change validation state. Native sample apps run separately; the web gallery displays captures only.

Evidence paths are checked even while a record is pending. Android toolbar asset checks also verify exact source/resource hashes, 24×24 root dimensions and native callsites. A verified static glyph covers that glyph's geometry and composition boundary; parent button, toolbar and spatial states retain their own records. Native XR scenes must be captured from the device compositor: copying the panel's 2D host window can produce an empty frame.

Keep React active in Figma. Do not create misleading React mappings for native code or infer tested status from the saved connection counter.

Platform filters show each binding’s own implementation and verification state. A React source connection never appears as a native connection. Platform alternatives must provide their own evidence and property mapping before they can pass the completion gate. The source links target the current implementation branch until it is merged.
