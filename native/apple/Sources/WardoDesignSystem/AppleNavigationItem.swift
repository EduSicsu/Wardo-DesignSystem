import SwiftUI

public enum WardoAppleNavigationItemLayout: String, CaseIterable, Sendable {
    case vertical, horizontal, textOnly
}

/// The Wardo destination atom from the canonical iOS navigation family.
/// This is an application-owned destination button. Native system tab and split
/// view compositions remain WardoTabView and WardoSidebar, with their own chrome.
public struct WardoAppleNavigationItem<Icon: View>: View {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.isEnabled) private var enabled
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ScaledMetric(relativeTo: .caption2) private var verticalFontSize = CGFloat(10)
    @ScaledMetric(relativeTo: .subheadline) private var horizontalFontSize = CGFloat(14)
    @ScaledMetric(relativeTo: .caption2) private var minimumLabelHeight = CGFloat(20)
    @ScaledMetric(relativeTo: .body) private var iconSize = CGFloat(24)
    @ScaledMetric(relativeTo: .body) private var verticalIconWidth = CGFloat(48)
    @ScaledMetric(relativeTo: .body) private var verticalIconHeight = CGFloat(32)
    private let title: String
    private let layout: WardoAppleNavigationItemLayout
    private let selected: Bool
    private let badge: String?
    private let badgeDescription: String?
    private let action: () -> Void
    private let icon: Icon

    public init(
        _ title: String,
        layout: WardoAppleNavigationItemLayout = .vertical,
        selected: Bool,
        badge: String? = nil,
        badgeDescription: String? = nil,
        action: @escaping () -> Void,
        @ViewBuilder icon: () -> Icon
    ) {
        self.title = title; self.layout = layout; self.selected = selected
        self.badge = badge; self.badgeDescription = badgeDescription
        self.action = action; self.icon = icon()
    }

    private var width: CGFloat { layout == .vertical ? 88 : layout == .horizontal ? 240 : 148 }
    private var iconView: some View {
        icon.font(.system(size: iconSize * 5 / 6))
            .frame(width: iconSize, height: iconSize).accessibilityHidden(true)
    }

    public var body: some View {
        Button(action: action) {
            Group {
                if layout == .vertical {
                    VStack(spacing: 4) {
                        iconView.frame(width: verticalIconWidth, height: verticalIconHeight)
                        Text(title).font(.system(size: verticalFontSize))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: minimumLabelHeight)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(4)
                } else {
                    HStack(spacing: 12) {
                        if layout == .horizontal { iconView }
                        Text(title).font(.system(size: horizontalFontSize))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, minHeight: minimumLabelHeight, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.horizontal, 16).padding(.vertical, 12)
                }
            }
            .padding(selected ? 1 : 0)
            .frame(width: dynamicTypeSize.isAccessibilitySize ? nil : width)
            .frame(maxWidth: dynamicTypeSize.isAccessibilitySize ? .infinity : nil)
            .frame(minHeight: layout == .vertical ? 54 : 44)
            .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
            .background {
                if selected { RoundedRectangle(cornerRadius: 24).fill(WardoColorToken.backgroundDefault.color(in: theme)) }
            }
            .overlay {
                if selected { RoundedRectangle(cornerRadius: 24).strokeBorder(WardoColorToken.borderDefault.color(in: theme), lineWidth: 1) }
            }
            .overlay(alignment: .topTrailing) {
                if let badge {
                    Text(badge).font(WardoFonts.label(12, weight: .medium, relativeTo: .caption))
                        .fixedSize()
                        .foregroundStyle(WardoColorToken.feedbackErrorForeground.color(in: theme))
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(WardoColorToken.feedbackErrorBackground.color(in: theme), in: Capsule())
                        .padding(.top, layout == .vertical ? 2 : 6)
                        .padding(.trailing, layout == .vertical ? 2 : 6)
                        .accessibilityHidden(true)
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 24))
        }
        .buttonStyle(.plain)
        .opacity(enabled ? 1 : 0.45)
        .accessibilityLabel(Text(title))
        .accessibilityValue(Text(badgeDescription ?? badge ?? ""))
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        #if !os(macOS)
        .hoverEffect(.highlight)
        #endif
    }
}
