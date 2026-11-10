import SwiftUI

public enum WardoDividerOrientation: CaseIterable, Hashable, Sendable { case horizontal, vertical }
public enum WardoDividerInset: CaseIterable, Hashable, Sendable { case none, start, both }

/// Shared Wardo separator paint. Supply a finite parent height for a vertical separator.
public struct WardoDivider: View {
    @Environment(\.wardoTheme) private var theme
    private let orientation: WardoDividerOrientation
    private let inset: WardoDividerInset
    public init(orientation: WardoDividerOrientation = .horizontal, inset: WardoDividerInset = .none) { self.orientation = orientation; self.inset = inset }
    public var body: some View {
        Rectangle().fill(WardoColorToken.separatorDefault.color(in: theme))
            .frame(width: orientation == .vertical ? 1 : nil, height: orientation == .horizontal ? 1 : nil)
            .padding(.leading, orientation == .horizontal && inset != .none ? 16 : 0)
            .padding(.trailing, orientation == .horizontal && inset == .both ? 16 : 0)
            .padding(.top, orientation == .vertical && inset != .none ? 16 : 0)
            .padding(.bottom, orientation == .vertical && inset == .both ? 16 : 0)
            .accessibilityHidden(true)
    }
}
