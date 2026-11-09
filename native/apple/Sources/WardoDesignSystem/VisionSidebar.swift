import SwiftUI

public enum WardoSidebarAccessory: Sendable { case symbol, symbolInCircle, bitmapCircle, bitmapRoundedRectangle }

/// Reusable row for the Wardo vision sidebar. Selection and navigation belong to the application.
public struct WardoVisionSidebarItem<Icon: View>: View {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.isEnabled) private var enabled
    @State private var hovering = false
    private let title: String
    private let counter: String?
    private let selected: Bool
    private let accessory: WardoSidebarAccessory
    private let icon: Icon
    private let action: () -> Void
    public init(_ title: String, counter: String? = nil, selected: Bool = false, accessory: WardoSidebarAccessory = .symbol, action: @escaping () -> Void, @ViewBuilder icon: () -> Icon) {
        self.title = title; self.counter = counter; self.selected = selected; self.accessory = accessory; self.action = action; self.icon = icon()
    }
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                accessoryView.frame(width: 32).accessibilityHidden(true)
                Text(title).font(WardoFonts.label(17, weight: .regular)).frame(maxWidth: .infinity, alignment: .leading)
                if let counter { Text(counter).font(WardoFonts.label(17, weight: .regular)).monospacedDigit() }
            }
            .padding(.leading, 8).padding(.trailing, 19).frame(minHeight: 56)
            .background(hovering || selected ? WardoColorToken.backgroundRaised.color(in: theme) : .clear, in: RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 12)
            .background(selected ? WardoColorToken.backgroundBrand.color(in: theme) : .clear)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain).foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
        .opacity(enabled ? 1 : 0.45).onHover { hovering = $0 }
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .listRowInsets(EdgeInsets()).listRowSeparator(.hidden).listRowBackground(Color.clear)
        #if !os(macOS)
        .hoverEffect(.highlight)
        #endif
    }
    @ViewBuilder private var accessoryView: some View {
        switch accessory {
        case .symbol: icon.frame(width: 20, height: 20)
        case .symbolInCircle: icon.frame(width: 20, height: 20).frame(width: 32, height: 32).background(WardoColorToken.backgroundRaised.color(in: theme), in: Circle())
        case .bitmapCircle: icon.frame(width: 28, height: 28).clipShape(Circle())
        case .bitmapRoundedRectangle: icon.frame(width: 28, height: 28).clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

public struct WardoVisionSidebarSectionHeader<Actions: View>: View {
    private let title: String
    private let actions: Actions
    public init(_ title: String, @ViewBuilder actions: () -> Actions) { self.title = title; self.actions = actions() }
    public var body: some View {
        HStack(spacing: 8) {
            Text(title).font(WardoFonts.label(20)).frame(maxWidth: .infinity, alignment: .leading).accessibilityAddTraits(.isHeader)
            actions.frame(minWidth: 44, minHeight: 44)
        }.padding(.horizontal, 24).frame(minHeight: 56)
            .listRowInsets(EdgeInsets()).listRowSeparator(.hidden).listRowBackground(Color.clear)
    }
}

/// A list-backed, scrollable sidebar with a title/action header and application-supplied row groups.
public struct WardoVisionSidebar<HeaderActions: View, Rows: View>: View {
    @Environment(\.wardoTheme) private var theme
    private let title: String
    private let actions: HeaderActions
    private let rows: Rows
    public init(_ title: String, @ViewBuilder actions: () -> HeaderActions, @ViewBuilder rows: () -> Rows) { self.title = title; self.actions = actions(); self.rows = rows() }
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Text(title).font(WardoFonts.label(28, weight: .regular)).frame(maxWidth: .infinity, alignment: .leading).accessibilityAddTraits(.isHeader)
                actions.frame(minWidth: 44, minHeight: 44)
            }.padding(.leading, 28).padding(.trailing, 20).frame(minHeight: 92)
            List { rows }.listStyle(.plain).scrollContentBackground(.hidden)
        }
        .frame(idealWidth: 320)
        .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
        .background(WardoColorToken.backgroundRaised.color(in: theme))
    }
}

/// A collapsible group; the binding lets the owning application restore expansion state.
public struct WardoVisionSidebarGroup<Disclosure: View, Rows: View>: View {
    @Binding private var expanded: Bool
    private let title: String
    private let showsHeader: Bool
    private let disclosure: (Bool) -> Disclosure
    private let rows: Rows
    public init(_ title: String, isExpanded: Binding<Bool>, showsHeader: Bool = true, @ViewBuilder disclosure: @escaping (Bool) -> Disclosure, @ViewBuilder rows: () -> Rows) {
        self.title = title; _expanded = isExpanded; self.showsHeader = showsHeader; self.disclosure = disclosure; self.rows = rows()
    }
    public var body: some View {
        Group {
            if showsHeader {
                WardoVisionSidebarSectionHeader(title) {
                    Button { expanded.toggle() } label: { disclosure(expanded).frame(width: 44, height: 44) }
                        .buttonStyle(.plain).accessibilityLabel("\(expanded ? "Hide" : "Show") \(title)")
                        .accessibilityValue(expanded ? "Expanded" : "Collapsed")
                }
            }
            if expanded { rows }
        }
    }
}
public extension WardoVisionSidebarGroup where Disclosure == Image {
    init(_ title: String, isExpanded: Binding<Bool>, showsHeader: Bool = true, @ViewBuilder rows: () -> Rows) {
        self.init(title, isExpanded: isExpanded, showsHeader: showsHeader, disclosure: { Image(systemName: $0 ? "chevron.down" : "chevron.forward") }, rows: rows)
    }
}
