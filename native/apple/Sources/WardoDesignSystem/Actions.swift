import SwiftUI

public enum WardoButtonHierarchy: Sendable { case primary, secondary, outline, text }
public enum WardoControlSize: Sendable {
    case small, regular, large
    var height: CGFloat { switch self { case .small: 32; case .regular: 44; case .large: 52 } }
    var labelSize: CGFloat { switch self { case .small: 14; case .regular: 17; case .large: 20 } }
    var padding: CGFloat { switch self { case .small: 12; case .regular: 20; case .large: 25 } }
}

public struct WardoButtonStyle: ButtonStyle {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.isEnabled) private var enabled
    public var hierarchy: WardoButtonHierarchy
    public var size: WardoControlSize
    public var selected: Bool
    public init(hierarchy: WardoButtonHierarchy = .primary, size: WardoControlSize = .regular, selected: Bool = false) {
        self.hierarchy = hierarchy; self.size = size; self.selected = selected
    }
    private var filled: Bool { hierarchy == .primary || selected }
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(WardoFonts.label(size.labelSize))
            .padding(.horizontal, size.padding)
            .frame(minHeight: size.height)
            .foregroundStyle((filled ? WardoColorToken.actionPrimaryForeground : .textPrimary).color(in: theme))
            .background {
                Capsule().fill((filled ? WardoColorToken.actionPrimary : .backgroundRaised).color(in: theme).opacity(hierarchy == .text && !selected ? 0 : 1))
            }
            .overlay { if hierarchy == .outline { Capsule().stroke(WardoColorToken.borderStrong.color(in: theme)) } }
            .opacity(enabled ? (configuration.isPressed ? 0.72 : 1) : 0.45)
            .contentShape(Capsule())
            .hoverEffect(.highlight)
    }
}

public struct WardoButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    private let hierarchy: WardoButtonHierarchy
    private let size: WardoControlSize
    private let selected: Bool
    public init(hierarchy: WardoButtonHierarchy = .primary, size: WardoControlSize = .regular, selected: Bool = false, action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.hierarchy = hierarchy; self.size = size; self.selected = selected; self.action = action; self.label = label()
    }
    public var body: some View {
        Button(action: action) { label }.buttonStyle(WardoButtonStyle(hierarchy: hierarchy, size: size, selected: selected))
            .accessibilityAddTraits(selected ? [.isSelected] : [])
    }
}

/// Native button semantics, with the Wardo visionOS platter and label tokens.
public struct WardoVisionButton<Label: View>: View {
    private let label: Label
    private let action: () -> Void
    private let size: WardoControlSize
    private let selected: Bool
    private let showsPlatter: Bool
    public init(size: WardoControlSize = .regular, selected: Bool = false, showsPlatter: Bool = true, action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.size = size; self.selected = selected; self.showsPlatter = showsPlatter; self.action = action; self.label = label()
    }
    public var body: some View {
        WardoButton(hierarchy: selected ? .primary : (showsPlatter ? .secondary : .text), size: size, selected: selected, action: action) { label }
    }
}

public struct WardoMenu<Label: View, Items: View>: View {
    private let label: Label
    private let items: Items
    public init(@ViewBuilder label: () -> Label, @ViewBuilder items: () -> Items) { self.label = label(); self.items = items() }
    public var body: some View { Menu { items } label: { label }.menuStyle(.button) }
}

public struct WardoMenuItem<Label: View>: View {
    private let label: Label
    private let role: ButtonRole?
    private let action: () -> Void
    public init(role: ButtonRole? = nil, action: @escaping () -> Void, @ViewBuilder label: () -> Label) { self.role = role; self.action = action; self.label = label() }
    public var body: some View { Button(role: role, action: action) { label } }
}

public struct WardoLink<Label: View>: View {
    private let destination: URL
    private let label: Label
    public init(destination: URL, @ViewBuilder label: () -> Label) { self.destination = destination; self.label = label() }
    public var body: some View { Link(destination: destination) { label }.font(WardoFonts.label()) }
}
