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

`WardoNavigationItem` implements Android's horizontal, vertical and text-only Wardo atoms. `WardoRailItem` and `WardoNavigationBarItem` are individual destinations, separate from whole navigation containers. Selection, labels, icons, badges and callbacks belong to the application. Put sibling custom items in a `selectableGroup`; inherit `LocalLayoutDirection` for RTL. The compact `WardoNavigationBar` uses Material's native `ShortNavigationBar`, with 64 dp minimum content height, shared destination widths and native system insets. Labels may increase its height when text wraps or scales.

`WardoToolbarArtwork(WardoToolbarGlyph.Share)` renders the exact bundled source geometry at 24 dp and inherits native content tint. A null description is decorative; the consuming action supplies its accessible label. All eight SVG sources, converted Android vector resources and hashes are recorded in `coverage/native-toolbar-assets.json`. Static glyph verification does not validate every parent toolbar surface, focus state or toggle configuration. The XR sample contains both the exact artwork and separately labelled 2D navigation compatibility exercises.

`WardoIndexBar` is a compact section scrubber with an optional application-owned selection binding and navigation callback. Its source entry belongs to visionOS. The package and sample also exercise its touch behavior on iPhone and iPad. Gaze interaction, VoiceOver, localized indices and exhaustive Dynamic Type review remain explicit gaps.

`WardoAppleNavigationItem` implements the canonical Wardo iOS destination atom in vertical, horizontal and text-only layouts. The application supplies selected state, activation, icon content, badge text and its localized accessibility description. It uses native SF typography and button semantics. At accessibility text sizes it uses the available width and scaled icon slots. System tab and split-view containers continue to use `WardoTabView` and `WardoSidebar`.

The four shared navigation glyphs retain their exact SVG sources in `coverage/assets/navigation`. Apple compiles universal template image sets; `wardoNavigationImage(.events).resizable().scaledToFit()` fits a caller-owned slot. Android exposes `WardoNavigationArtwork(WardoNavigationGlyph.Events)`. Both inherit the consuming control's semantic color. Hashes, resource names and image-set settings are checked through `coverage/navigation-artwork-assets.json`.

`npm run coverage:lookup -- NODE_ID --platform visionOS` finds source, example, review gaps and verification state without requiring an active native framework in Figma. Platform alternatives appear in `/coverage`; native samples run separately from the web gallery.

## Figma and licenses

React remains active in Figma. The catalogue records 374 saved app source links and six historical example links pending cleanup; these are source connections, not verified implementation counts. Compatible native connection artifacts remain under `figma` for later activation.

Bundled fonts retain their SIL Open Font Licenses in the package resources. No SDK or platform license is accepted by build scripts.

## Native presentation examples

The Apple sample’s **Native presentation examples** screen exercises system alerts with zero, one or two application-bound fields; optional destructive actions; context-menu previews, disabled actions and submenus; and native sharing. iPhone and iPad use an anchored `.popover` for `NativeActivityView`, allowing compact-width adaptation to the native share sheet. The OS supplies contacts, destinations and app icons. `applicationActivities`, exclusions and the completion callback are caller-owned; items are immutable for a single presentation.

`NativePageSheetModifier` maps the iPhone **Sheet - Full Screen** specimen to an actual large page sheet with a system grabber. Present a second sheet from its content to obtain the stacked variant. Include a `NavigationStack` and semantic cancellation/confirmation toolbar placements in the caller’s content. `NativeFullScreenSheetModifier` remains available for consumers that require a true full-screen cover; it is a different presentation. The alert and context-menu layouts adapt to the device and text size: the Figma side/alignment/stacking specimens do not authorize forcing system geometry.

Native context-menu builders can include `ControlGroup { ... }.controlGroupStyle(.palette)` for the source’s quick-action row, followed by native `Button`, `Section` and `Menu` entries. The sample exercises all of these compositions. Its appearance controls cover dark mode, RTL and accessibility text sizes; native UI audits check descriptions, traits, touch regions and clipping. These automated audits supplement per-entry review and do not stand in for manual assistive-technology checks.

## Sidebar search

`WardoSidebarSearchField("Search events", text: $query, onSubmit: runSearch, onVoiceSearch: beginVoiceSearch)` implements the native-derived iOS/iPadOS sidebar search. It uses the exact bundled search/microphone vectors and Wardo Geologica/semantic colors. `voiceSearchLabel` is localizable; the application owns any microphone permissions and recognition flow. The component requests no permissions itself. Inherit layout direction and enabled state from the application environment.

The sidebar-search sample exercises controlled queries, submission, voice callback, RTL, disabled state, dark appearance and Dynamic Type. Two tests pass on both iPhone and iPad; the package also compiles and passes 13 tests on macOS. Native manual VoiceOver, hardware keyboard, long localized text and exhaustive source-specimen review remain pending. The microphone uses a 44-point touch target while preserving its 17×22 source artwork. Compatible SwiftUI source metadata is retained in `figma/native-mappings.json`; no native connection was activated.

The `--wardo-native-presentations` launch argument opens the native presentation fixture directly. `--wardo-native-dark`, `--wardo-native-rtl` and `--wardo-native-large-text` expose its appearance controls. The sample inherits the system content size unless its larger-text control is enabled. The scaling regression measures the native alert title; UIKit's iPad input rows remain fixed-height at accessibility sizes.

To exercise actual simulator hardware-key events with an installed AXe CLI and an already-built sample:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer AXE_BIN=/path/to/axe \
  node native/apple/Sample/Scripts/check-alert-keyboard.mjs SIMULATOR_ID /tmp/alert-keyboard.json
```

The driver checks Tab, Return and Escape using synthetic event data. It fails rather than recording success if field values or callbacks differ. iPad passes; iPhone remains unresolved. Native per-entry validation stays pending; see `coverage/evidence/2026-11-10/native-presentations-review.json` for passed checks and limitations. No Figma connections are created by these fixtures.
