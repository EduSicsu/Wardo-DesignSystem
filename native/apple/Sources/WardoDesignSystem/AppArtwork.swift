import SwiftUI

/// Application-provided artwork; system application logos are not substituted for product icons.
public struct WardoAppIcon<Artwork: View, Badge: View>: View {
    private let name: String
    private let size: CGFloat
    private let showsName: Bool
    private let artwork: Artwork
    private let badge: Badge
    public init(_ name: String, size: CGFloat = 128, showsName: Bool = true, @ViewBuilder artwork: () -> Artwork, @ViewBuilder badge: () -> Badge) {
        self.name = name; self.size = size; self.showsName = showsName; self.artwork = artwork(); self.badge = badge()
    }
    public var body: some View {
        VStack(spacing: 8) {
            artwork.frame(width: size, height: size).clipShape(Circle()).accessibilityElement(children: .ignore).accessibilityLabel(name).overlay(alignment: .bottomTrailing) { badge }
            if showsName { Text(name).font(WardoFonts.label(14)).lineLimit(2).multilineTextAlignment(.center).accessibilityHidden(true) }
        }.accessibilityElement(children: .combine)
    }
}
public extension WardoAppIcon where Badge == EmptyView {
    init(_ name: String, size: CGFloat = 128, showsName: Bool = true, @ViewBuilder artwork: () -> Artwork) { self.init(name, size: size, showsName: showsName, artwork: artwork) { EmptyView() } }
}
public struct WardoIconBadge: View {
    @Environment(\.wardoTheme) private var theme
    private let text: String
    private let label: String
    public init(_ text: String = "", accessibilityLabel: String) { self.text = text; self.label = accessibilityLabel }
    public var body: some View {
        Text(text).font(WardoFonts.label(10)).padding(.horizontal, text.isEmpty ? 0 : 4).frame(minWidth: 12, minHeight: 12)
            .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
            .background(WardoColorToken.backgroundRaised.color(in: theme), in: Capsule()).accessibilityLabel(label)
    }
}
/// The native notification scrim consists of the two alpha layers present in the design.
public struct WardoBackdrop: View {
    public init() {}
    public var body: some View { Color.black.opacity(0.25).overlay(Color.black.opacity(0.05)).ignoresSafeArea().allowsHitTesting(false).accessibilityHidden(true) }
}
