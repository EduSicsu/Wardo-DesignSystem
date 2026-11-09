import SwiftUI

/// Application-owned swipe actions. Destructive actions never execute on a full swipe.
public struct WardoSwipeAction: Identifiable {
    public let id: String
    public let title: String
    public let symbol: String
    public let role: ButtonRole?
    public let tint: Color
    public let action: () -> Void
    public init(id: String, title: String, systemImage: String, role: ButtonRole? = nil, tint: Color = .accentColor, action: @escaping () -> Void) {
        self.id = id; self.title = title; symbol = systemImage; self.role = role; self.tint = tint; self.action = action
    }
}

/// Place inside a List to retain native reveal, cancellation, accessibility, and RTL behavior.
public struct WardoSwipeActionRow<Content: View>: View {
    private let leading: [WardoSwipeAction]
    private let trailing: [WardoSwipeAction]
    private let multiline: Bool
    private let content: Content
    public init(multiline: Bool = false, leading: [WardoSwipeAction] = [], trailing: [WardoSwipeAction] = [], @ViewBuilder content: () -> Content) {
        self.multiline = multiline; self.leading = leading; self.trailing = trailing; self.content = content()
    }
    public var body: some View {
        content.frame(minHeight: multiline ? 68 : 52)
            #if os(iOS)
            .swipeActions(edge: .leading, allowsFullSwipe: false) { actions(leading) }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) { actions(trailing) }
            #endif
    }
    @ViewBuilder private func actions(_ items: [WardoSwipeAction]) -> some View {
        ForEach(items) { item in
            Button(role: item.role, action: item.action) { Label(item.title, systemImage: item.symbol) }.tint(item.tint)
        }
    }
}

public struct WardoChip<Label: View>: View {
    private let selected: Bool
    private let action: () -> Void
    private let label: Label
    public init(selected: Bool = false, action: @escaping () -> Void, @ViewBuilder label: () -> Label) { self.selected = selected; self.action = action; self.label = label() }
    public var body: some View {
        WardoButton(hierarchy: .outline, size: .small, selected: selected, action: action) { label }
            .frame(minWidth: 44, minHeight: 44).contentShape(Rectangle())
    }
}
