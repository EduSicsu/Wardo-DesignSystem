import SwiftUI

#if os(iOS)
/// Attach to a TabView. The system owns expanded/inline placement and the minimization animation.
public struct WardoTabBarAccessory<Accessory: View>: ViewModifier {
    private let accessory: Accessory
    public init(@ViewBuilder content: () -> Accessory) { accessory = content() }
    public func body(content: Content) -> some View {
        content.tabViewBottomAccessory { accessory.frame(minHeight: 44) }
    }
}
public extension View {
    func wardoTabBarAccessory<Accessory: View>(@ViewBuilder content: () -> Accessory) -> some View {
        modifier(WardoTabBarAccessory(content: content))
    }
}
#endif
