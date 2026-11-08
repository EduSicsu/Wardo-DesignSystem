import SwiftUI

/// SF Symbols keep their native shape, Dynamic Type behavior and rendering mode.
public struct WardoSystemIcon: View {
    private let name: String
    private let label: String?
    public init(_ name: String, accessibilityLabel: String? = nil) { self.name = name; label = accessibilityLabel }
    public var body: some View {
        if let label { Image(systemName: name).accessibilityLabel(label) }
        else { Image(systemName: name).accessibilityHidden(true) }
    }
}
