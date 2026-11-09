# Independent coverage registry

`registry.json` accounts for all 797 published Figma nodes. Stable identifiers are `wardo-<node-id-with-hyphens>`. `implementations.json` contains reviewed overrides; `scripts/build-coverage.mjs` deterministically merges them with the published inventory and existing connections. Regenerate with `npm run coverage:build`.

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

Keep React active in Figma. Do not create misleading React mappings for native code or infer tested status from the saved connection counter.
