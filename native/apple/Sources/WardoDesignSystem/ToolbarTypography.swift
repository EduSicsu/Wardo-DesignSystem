import SwiftUI

public enum WardoToolbarTextStyle: CaseIterable, Hashable, Sendable {
    case largeTitle, bodyTitle, subheadlineTitle, subheadlineSubtitle, captionSubtitle
    var pointSize: CGFloat { switch self { case .largeTitle: 34; case .bodyTitle: 17; case .subheadlineTitle, .subheadlineSubtitle: 15; case .captionSubtitle: 12 } }
    var lineHeight: CGFloat { switch self { case .largeTitle: 41; case .bodyTitle: 22; case .subheadlineTitle: 18; case .subheadlineSubtitle: 20; case .captionSubtitle: 14 } }
    var tracking: CGFloat { switch self { case .largeTitle: 0.4; case .bodyTitle: -0.43; case .subheadlineTitle: -0.23; case .subheadlineSubtitle: -0.25; case .captionSubtitle: 0 } }
    var isSubtitle: Bool { self == .subheadlineSubtitle || self == .captionSubtitle }
    var textStyle: Font.TextStyle { switch self { case .largeTitle: .largeTitle; case .bodyTitle: .body; case .subheadlineTitle, .subheadlineSubtitle: .subheadline; case .captionSubtitle: .caption } }
}

/// Wardo's localized Apple toolbar text styles, with application-owned content and Dynamic Type scaling.
public struct WardoToolbarText: View {
    @Environment(\.wardoTheme) private var theme
    @ScaledMetric private var scale: CGFloat
    private let text: String
    private let style: WardoToolbarTextStyle
    public init(_ text: String, style: WardoToolbarTextStyle = .bodyTitle) {
        self.text = text; self.style = style; _scale = ScaledMetric(wrappedValue: 1, relativeTo: style.textStyle)
    }
    public var body: some View {
        Text(text)
            .font(WardoFonts.label(style.pointSize, weight: style.isSubtitle ? .medium : .bold, relativeTo: style.textStyle))
            .tracking(style.tracking * scale)
            .foregroundStyle((style.isSubtitle ? WardoColorToken.textSecondary : .textPrimary).color(in: theme))
            .frame(minHeight: style.lineHeight * scale, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .accessibilityAddTraits(style.isSubtitle ? [] : [.isHeader])
    }
}
