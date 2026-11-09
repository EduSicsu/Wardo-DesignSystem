import SwiftUI

/// Uses native navigation chrome, including the platform's back gesture and title behavior.
public struct WardoNavigationStack<Root: View, Leading: View, Trailing: View>: View {
    private let title: String
    private let root: Root
    private let leading: Leading
    private let trailing: Trailing
    public init(_ title: String, @ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing, @ViewBuilder content: () -> Root) {
        self.title = title; self.leading = leading(); self.trailing = trailing(); root = content()
    }
    public var body: some View {
        NavigationStack {
            root.navigationTitle(title).toolbar {
                ToolbarItem(placement: .cancellationAction) { leading }
                ToolbarItem(placement: .primaryAction) { trailing }
            }
        }
    }
}

public struct WardoTabView<Selection: Hashable, Content: View>: View {
    @Binding private var selection: Selection
    private let content: Content
    public init(selection: Binding<Selection>, @ViewBuilder content: () -> Content) { _selection = selection; self.content = content() }
    public var body: some View { TabView(selection: $selection) { content } }
}

public struct WardoSidebar<Selection: Hashable, Rows: View, Detail: View>: View {
    @Binding private var selection: Selection?
    private let title: String
    private let rows: Rows
    private let detail: Detail
    public init(_ title: String, selection: Binding<Selection?>, @ViewBuilder rows: () -> Rows, @ViewBuilder detail: () -> Detail) {
        self.title = title; _selection = selection; self.rows = rows(); self.detail = detail()
    }
    public var body: some View {
        NavigationSplitView { List(selection: $selection) { rows }.navigationTitle(title) } detail: { detail }
    }
}

public struct WardoToolbar<Items: View>: View {
    @Environment(\.wardoTheme) private var theme
    private let items: Items
    public init(@ViewBuilder items: () -> Items) { self.items = items() }
    public var body: some View {
        HStack(spacing: 8) { items }.padding(12)
            .background(WardoColorToken.backgroundRaised.color(in: theme), in: Capsule())
            .overlay { Capsule().stroke(WardoColorToken.borderDefault.color(in: theme)) }
    }
}

public struct WardoToolbarButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label) { self.action = action; self.label = label() }
    public var body: some View { Button(action: action) { label }.buttonStyle(.bordered) }
}

public struct WardoToolbarTitle: View {
    private let title: String
    private let subtitle: String?
    private let titleStyle: WardoToolbarTextStyle
    private let subtitleStyle: WardoToolbarTextStyle
    public init(_ title: String, subtitle: String? = nil, titleStyle: WardoToolbarTextStyle = .bodyTitle, subtitleStyle: WardoToolbarTextStyle = .subheadlineSubtitle) {
        self.title = title; self.subtitle = subtitle; self.titleStyle = titleStyle; self.subtitleStyle = subtitleStyle
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            WardoToolbarText(title, style: titleStyle)
            if let subtitle { WardoToolbarText(subtitle, style: subtitleStyle) }
        }
    }
}

public struct WardoIndexBar: View {
    private let sections: [String]
    private let navigate: (String) -> Void
    public init(sections: [String], navigate: @escaping (String) -> Void) { self.sections = sections; self.navigate = navigate }
    public var body: some View {
        ScrollView(.vertical) { VStack(spacing: 4) { ForEach(Array(sections.enumerated()), id: \.offset) { _, section in Button(section) { navigate(section) }.buttonStyle(.plain).frame(minWidth: 44, minHeight: 30) } } }
            .accessibilityLabel("Section index")
    }
}
