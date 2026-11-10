# Working on Wardo

Use the independent catalogue before implementing a Figma node:

```
npm run coverage:lookup -- NODE_ID --platform PLATFORM
```

Keep application state, callbacks, and content owned by the consuming application. Preserve public APIs. Update the reviewed overrides in `coverage/implementations.json`, regenerate the registry, and retain explicit gaps until implementation, properties, examples and evidence are complete. Never use source availability or a Figma link as proof of validation. React remains the active Figma framework.

Run the relevant web checks and platform sample checks described in README.md and native/README.md. Do not accept Apple or Android legal agreements. Native screenshots are previews, not automatic proof of fidelity, accessibility or physical XR interaction quality.

App coverage is defined by coverage/scope.json. Implement and connect only reusable app components and their internal building blocks/icons. Documentation, showcase screens, original device/UI-kit references, archives, and Apple Watch/watchOS are excluded. Examples may remain development fixtures; do not promote them to app coverage or create new source connections for them. Figma editing remains deferred until the user resumes it; record pending cleanup without claiming existing links were deleted.
