import SwiftUI

/// Real native windows supply their own close, minimize, expand, and active-window appearance.
@MainActor public struct WardoWindowScene<Content: View>: Scene {
    private let title: String
    private let content: () -> Content
    public init(_ title: String, @ViewBuilder content: @escaping () -> Content) { self.title = title; self.content = content }
    public var body: some Scene { WindowGroup(title) { content() } }
}

/// The reusable custom glass surface shown in the Apple toolbar reference, not a simulated window control.
public struct WardoGlassSurface<Content: View>: View {
    private let primary: Bool
    private let content: Content
    public init(primary: Bool = false, @ViewBuilder content: () -> Content) { self.primary = primary; self.content = content() }
    public var body: some View {
        content.frame(width: 48, height: 48)
            #if os(visionOS)
            .background(.regularMaterial, in: Circle())
            #else
            .glassEffect(.regular.tint(primary ? .accentColor : .clear), in: Circle())
            #endif
    }
}
