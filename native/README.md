# Native Wardo sources

These sources extend the existing React library with Apple SwiftUI and Android Jetpack Compose packages. Native compilation and runtime checks were explicitly deferred by the owner. Do not describe these packages as build-verified or visually complete.

## Apple

`apple/Package.swift` targets iOS/iPadOS 26, visionOS 26 and macOS 26. Add this local package to an Xcode application and import `WardoDesignSystem`. The library bundles and registers Geologica and Source Serif 4. Ten themes use the same Figma semantic color snapshot as React.

Use `WardoButton`, the input/navigation/content components and `wardoTheme(_:)` for Wardo styling. `NativeAlertModifier`, `NativeContextMenuModifier`, `NativeSheetModifier`, `NativeFullScreenSheetModifier`, `NativeActivityView` and `NativeShareLink` intentionally use the operating system's presentation, typography and materials for the unmodified native reference designs. Pass actions, bindings and content; the package does not implement app business logic.

The native date and color pickers currently use system presentations. Their Wardo visionOS custom gallery geometry is not fully reproduced. The generic slider uses the system slider rather than the visionOS filled-track design. These are implementation gaps, not verified matches, and those particular visionOS masters must remain pending until their custom presentations are implemented.

After Xcode first-launch setup is complete, compile against both iOS Simulator and visionOS Simulator and exercise keyboard/VoiceOver, RTL, Dynamic Type, focus, dismissal, gaze and pinch behavior. No signing or paid developer membership is needed for compilation alone.

## Android

`android` is a Compose library using Material 3, compile SDK 36, minimum SDK 26 and Java 17. Its build configuration pins Android Gradle Plugin 9.5.0, Kotlin/Compose compiler 2.4.10 and Compose BOM 2026.09.00. Use Gradle 9.6.0. Gradle and Android SDK installation are not bundled or silently accepted.

`WardoTheme` supplies the ten semantic palettes and bundled fonts. Components expose application-owned state and callbacks. Dialogs are application dialogs, not permission prompts. Android XR spatial window placement, comfort and gaze handling are not implemented by the ordinary 2D Compose wrappers and must not be claimed as verified XR coverage.

## Connection state

Source availability, a saved source connection, an active framework, a published property-aware template and a verified native implementation are different states. The Figma Professional plan permits one active framework. React remains active; native activation must not silently deactivate it. See the per-entry registry and `figma/STATUS.md`.

## Font licenses

The bundled fonts are from the official Google Fonts repository, under their SIL Open Font Licenses retained in `licenses`. Native system references continue to use Apple or Material system typography where specified.
