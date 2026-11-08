import SwiftUI

public struct WardoList<Rows: View>: View {
    private let rows: Rows
    public init(@ViewBuilder rows: () -> Rows) { self.rows = rows() }
    public var body: some View { List { rows }.listStyle(.plain) }
}

public struct WardoListRow<Leading: View, Trailing: View>: View {
    private let title: String
    private let subtitle: String?
    private let leading: Leading
    private let trailing: Trailing
    public init(_ title: String, subtitle: String? = nil, @ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) { self.title = title; self.subtitle = subtitle; self.leading = leading(); self.trailing = trailing() }
    public var body: some View {
        HStack(spacing: 12) {
            leading
            VStack(alignment: .leading, spacing: 4) { Text(title).font(WardoFonts.label()); if let subtitle { Text(subtitle).font(WardoFonts.body(12)).foregroundStyle(.secondary) } }
            Spacer(minLength: 8)
            trailing
        }.frame(minHeight: subtitle == nil ? 44 : 64).accessibilityElement(children: .combine)
    }
}

public struct WardoSection<Content: View>: View {
    private let title: String
    private let footer: String?
    private let content: Content
    public init(_ title: String, footer: String? = nil, @ViewBuilder content: () -> Content) { self.title = title; self.footer = footer; self.content = content() }
    public var body: some View { Section { content } header: { Text(title) } footer: { if let footer { Text(footer) } } }
}

public struct WardoDisclosure<Content: View>: View {
    @Binding private var expanded: Bool
    private let title: String
    private let content: Content
    public init(_ title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) { self.title = title; _expanded = isExpanded; self.content = content() }
    public var body: some View { DisclosureGroup(title, isExpanded: $expanded) { content } }
}

public struct WardoAvatar<ImageContent: View>: View {
    private let label: String
    private let size: CGFloat
    private let image: ImageContent
    public init(_ label: String, size: CGFloat = 44, @ViewBuilder image: () -> ImageContent) { self.label = label; self.size = size; self.image = image() }
    public var body: some View { image.frame(width: size, height: size).clipShape(Circle()).accessibilityLabel(label) }
}

public struct WardoNotification<Preview: View, Actions: View>: View {
    @Environment(\.wardoTheme) private var theme
    @Binding private var expanded: Bool
    private let title: String
    private let message: String
    private let preview: Preview
    private let actions: Actions
    public init(_ title: String, message: String, isExpanded: Binding<Bool>, @ViewBuilder preview: () -> Preview, @ViewBuilder actions: () -> Actions) { self.title = title; self.message = message; _expanded = isExpanded; self.preview = preview(); self.actions = actions() }
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button { expanded.toggle() } label: { VStack(alignment: .leading, spacing: 4) { Text(title).font(WardoFonts.label()); Text(message).font(WardoFonts.body(14)).lineLimit(expanded ? nil : 1) }.frame(maxWidth: .infinity, alignment: .leading) }
                .buttonStyle(.plain).accessibilityHint(expanded ? "Collapse notification" : "Expand notification")
            if expanded { preview; actions }
        }.padding(20).foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
            .background(WardoColorToken.backgroundRaised.color(in: theme), in: RoundedRectangle(cornerRadius: expanded ? 32 : 100))
            .overlay { RoundedRectangle(cornerRadius: expanded ? 32 : 100).stroke(WardoColorToken.borderDefault.color(in: theme)) }
    }
}

public struct WardoNotice<Actions: View>: View {
    @Environment(\.wardoTheme) private var theme
    private let message: String
    private let actions: Actions
    public init(_ message: String, @ViewBuilder actions: () -> Actions) { self.message = message; self.actions = actions() }
    public var body: some View { HStack { Text(message).font(WardoFonts.body()); Spacer(); actions }.padding().background(WardoColorToken.backgroundRaised.color(in: theme), in: RoundedRectangle(cornerRadius: 16)) }
}

public struct WardoProgress: View {
    private let label: String
    private let value: Double?
    public init(_ label: String, value: Double? = nil) { self.label = label; self.value = value.map { min(1, max(0, $0)) } }
    public var body: some View { if let value { ProgressView(label, value: value, total: 1) } else { ProgressView(label) } }
}
