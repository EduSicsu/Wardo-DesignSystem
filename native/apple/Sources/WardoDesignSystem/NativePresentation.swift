import SwiftUI

/// Preserves Apple's system alert, field and action layout instead of redrawing it.
public struct NativeAlertModifier<Actions: View>: ViewModifier {
    @Binding private var presented: Bool
    private let title: String
    private let message: String
    private let actions: () -> Actions
    public init(_ title: String, isPresented: Binding<Bool>, message: String, @ViewBuilder actions: @escaping () -> Actions) { self.title = title; _presented = isPresented; self.message = message; self.actions = actions }
    public func body(content: Content) -> some View { content.alert(title, isPresented: $presented) { actions() } message: { Text(message) } }
}

public struct NativeContextMenuModifier<Items: View>: ViewModifier {
    private let items: () -> Items
    public init(@ViewBuilder items: @escaping () -> Items) { self.items = items }
    public func body(content: Content) -> some View { content.contextMenu { items() } }
}

public struct NativeSheetModifier<SheetContent: View>: ViewModifier {
    @Binding private var presented: Bool
    private let sheet: () -> SheetContent
    public init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> SheetContent) { _presented = isPresented; sheet = content }
    public func body(content: Content) -> some View { content.sheet(isPresented: $presented) { sheet() } }
}

#if os(iOS) || os(visionOS)
public struct NativeFullScreenSheetModifier<SheetContent: View>: ViewModifier {
    @Binding private var presented: Bool
    private let sheet: () -> SheetContent
    public init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> SheetContent) { _presented = isPresented; sheet = content }
    public func body(content: Content) -> some View { content.fullScreenCover(isPresented: $presented) { sheet() } }
}
#endif

/// The system owns the share destination list, privacy prompts and dismissal.
public struct NativeShareLink<Label: View>: View {
    private let url: URL
    private let label: Label
    public init(item: URL, @ViewBuilder label: () -> Label) { url = item; self.label = label() }
    public var body: some View { ShareLink(item: url) { label } }
}

public struct NativeTooltip<Content: View>: View {
    private let text: String
    private let content: Content
    public init(_ text: String, @ViewBuilder content: () -> Content) { self.text = text; self.content = content() }
    public var body: some View { content.help(text).accessibilityHint(text) }
}
