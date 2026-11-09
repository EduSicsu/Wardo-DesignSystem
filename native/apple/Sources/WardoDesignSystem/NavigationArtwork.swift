import SwiftUI

public enum WardoNavigationGlyph: String, CaseIterable, Sendable {
    case events = "WardoNavigationEvents"
    case saved = "WardoNavigationSaved"
    case notifications = "WardoNavigationNotifications"
    case profile = "WardoNavigationProfile"
}

/// Exact source SVGs compiled as template image assets. The surrounding control
/// owns color and accessibility; use resizable/scaledToFit for a scalable slot.
public func wardoNavigationImage(_ glyph: WardoNavigationGlyph) -> Image {
    Image(decorative: glyph.rawValue, bundle: .module).renderingMode(.template)
}
