import SwiftUI

public enum WardoToolbarPosition: Sendable { case top, bottom }
/// Apply to content inside a NavigationStack; the OS owns bar layout and safe areas.
public struct WardoPlatformToolbar<Leading: View, Trailing: View>: ViewModifier {
    private let title: String
    private let position: WardoToolbarPosition
    private let leading: Leading
    private let trailing: Trailing
    public init(_ title: String, position: WardoToolbarPosition = .top, @ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
        self.title = title; self.position = position; self.leading = leading(); self.trailing = trailing()
    }
    public func body(content: Content) -> some View {
        content.toolbar {
            if position == .top {
                #if os(macOS)
                ToolbarItem(placement: .navigation) { leading }
                ToolbarItem(placement: .principal) { Text(title) }
                ToolbarItem(placement: .primaryAction) { trailing }
                #else
                ToolbarItem(placement: .topBarLeading) { leading }
                ToolbarItem(placement: .principal) { Text(title) }
                ToolbarItem(placement: .topBarTrailing) { trailing }
                #endif
            } else {
                #if os(macOS)
                ToolbarItem(placement: .automatic) { HStack { leading; Spacer(); trailing } }
                #else
                ToolbarItem(placement: .bottomBar) { HStack { leading; Spacer(); trailing } }
                #endif
            }
        }
    }
}
