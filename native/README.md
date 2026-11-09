# Native Wardo packages

SwiftUI and Jetpack Compose implementations accompany the React library. Build and runtime checks are now included. A successful package build is not a claim that every Figma entry, variant or interaction is validated; the independent `coverage/registry.json` records those separately.

## Apple

`apple/Package.swift` targets iOS/iPadOS 26, visionOS 26 and macOS 26. Import `WardoDesignSystem`. The package bundles Geologica and Source Serif 4. System-reference components retain native typography, presentation and materials.

Select an installed Xcode for each command without changing the machine's global developer directory:

```sh
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
swift test --package-path native/apple
xcodebuild -project native/apple/Sample/WardoCatalogue.xcodeproj -scheme WardoCatalogue -showdestinations
```

Run the sample tests with an available device identifier:

```sh
xcodebuild -project native/apple/Sample/WardoCatalogue.xcodeproj \
  -scheme WardoCatalogue -destination 'platform=iOS Simulator,id=DEVICE_ID' \
  -parallel-testing-enabled NO ARCHS=arm64 ONLY_ACTIVE_ARCH=YES CODE_SIGNING_ALLOWED=NO test
```

For Vision Pro, use `platform=visionOS Simulator`. Simulator runtimes must already be installed. Apple first-launch setup and legal agreements require the user's own action.

The sample owns state and callbacks. Custom vision controls include filled-track sliders, grid/spectrum/channel colour selection, date selection, checkbox and switch styles. System alerts, sheets, context menus, share sheets and window controls use platform implementations. Component-specific fidelity, accessibility and variant checks remain visible as outstanding registry gaps.

## Android

Requires Java 17, Android SDK platform 37.2, platform tools, and the checked-in Gradle wrapper. AGP 9.5.0, the Compose compiler 2.4.10 and BOM 2026.09.00 are pinned. Configure `JAVA_HOME` and `ANDROID_HOME` for your installation. SDK legal agreements remain user actions.

```sh
cd native/android
./gradlew assembleDebug :sample:assembleDebug :xr:assembleDebug :xr-sample:assembleDebug
./gradlew :sample:connectedDebugAndroidTest
```

The library and phone sample support API 26+. The XR module and dedicated XR sample require API 34+ and a compatible Android XR runtime. The sample requests managed Full Space and exercises an actual movable/resizable spatial panel, anchored toolbar and spatial dialog. A 2D build does not establish XR runtime or comfort validation.

## Tokens and lookup

Run `npm run tokens` from the repository root to regenerate web, Swift and Kotlin semantic colours and all eight shared control-size profiles from the same token sources. `npm run tokens:check` checks that generated files match the source without changing files. Swift exposes `WardoSharedControlSize`/`WardoSharedControlMetrics`; Compose exposes the equivalent enum and `wardoControlMetrics`. Content padding and the three corner-radius conditions are also generated. Compose font dimensions use `sp`; apply Swift font dimensions through `WardoFonts.label(_:relativeTo:)` for Dynamic Type. These shared profiles do not replace native system-control geometry or platform-specific typography.

`WardoPageControl` uses the actual iOS page control; the separate `WardoVisionPageControl` has compact indicators, application-owned selection, a bounded window for large page counts, adjustable accessibility and keyboard support. `WardoPageDot` is a decorative internal building block. The sample includes a dedicated paging screen. VoiceOver and exhaustive source-variant validation remain pending in the registry.

Android's expanded rail uses Material's `WideNavigationRail`, separately from the compact `WardoNavigationRail`. `WardoExpandedNavigationRail` exposes docked/floating surfaces, top/center alignment and application-owned menu, FAB and content slots; `WardoExpandedRailItem` retains native selection and interaction semantics. The XR sample includes a rail exercise inside its spatial panel. Its numbered icon slots exercise caller content; they are not a Figma artwork preview.

`npm run coverage:lookup -- NODE_ID --platform visionOS` finds source, example, review gaps and verification state without requiring an active native framework in Figma. Platform alternatives appear in `/coverage`; native samples run separately from the web gallery.

## Figma and licenses

React remains active in Figma. The 199 saved links are source connections, not verified implementation counts. Compatible native connection artifacts remain under `figma` for later activation.

Bundled fonts retain their SIL Open Font Licenses in the package resources. No SDK or platform license is accepted by build scripts.
