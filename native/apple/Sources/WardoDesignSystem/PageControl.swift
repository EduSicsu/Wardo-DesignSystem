import SwiftUI
#if os(iOS)
import UIKit
#endif

/// A decorative building block. Product paging should use WardoPageControl.
public struct WardoPageDot: View {
    @Environment(\.wardoTheme) private var theme
    private let selected: Bool
    public init(selected: Bool = false) { self.selected = selected }
    public var body: some View {
        Circle().fill((selected ? WardoColorToken.textPrimary : .textSecondary).color(in: theme))
            .opacity(selected ? 1 : 0.55).frame(width: 8, height: 8).accessibilityHidden(true)
    }
}

/// Selection is a zero-based application-owned page index. iOS uses UIPageControl,
/// retaining the system's scrubbing, keyboard and VoiceOver behavior.
public struct WardoPageControl: View {
    @Binding private var selection: Int
    private let count: Int
    private let label: String
    public init(_ label: String, selection: Binding<Int>, count: Int) {
        precondition(count > 0)
        self.label = label; _selection = selection; self.count = count
    }
    public var body: some View {
        #if os(iOS)
        WardoNativePageControl(label: label, selection: $selection, count: count).frame(minHeight: 44)
        #else
        WardoVisionPageControl(label, selection: $selection, count: count)
        #endif
    }
}

#if os(iOS)
private struct WardoNativePageControl: UIViewRepresentable {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(\.isEnabled) private var isEnabled
    let label: String
    @Binding var selection: Int
    let count: Int
    func makeCoordinator() -> Coordinator { Coordinator(selection: $selection) }
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.allowsContinuousInteraction = true
        control.backgroundStyle = .automatic
        control.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        return control
    }
    func updateUIView(_ control: UIPageControl, context: Context) {
        context.coordinator.selection = $selection
        control.numberOfPages = count
        control.currentPage = min(max(selection, 0), count - 1)
        control.currentPageIndicatorTintColor = UIColor(WardoColorToken.textBrand.color(in: theme))
        control.pageIndicatorTintColor = UIColor(WardoColorToken.textSecondary.color(in: theme).opacity(0.65))
        control.semanticContentAttribute = layoutDirection == .rightToLeft ? .forceRightToLeft : .forceLeftToRight
        control.isEnabled = isEnabled
        control.accessibilityLabel = label
    }
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIPageControl, context: Context) -> CGSize? {
        let size = uiView.size(forNumberOfPages: count)
        return CGSize(width: max(44, size.width), height: max(44, size.height))
    }
    final class Coordinator: NSObject {
        var selection: Binding<Int>
        init(selection: Binding<Int>) { self.selection = selection }
        @objc func changed(_ control: UIPageControl) { selection.wrappedValue = control.currentPage }
    }
}
#endif

/// Compact visionOS indicators form one adjustable accessibility control rather
/// than several tiny targets. Visible indicators map taps to application pages.
public struct WardoVisionPageControl: View {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.layoutDirection) private var direction
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var selection: Int
    private let label: String
    private let count: Int
    public init(_ label: String, selection: Binding<Int>, count: Int) {
        precondition(count > 0)
        self.label = label; _selection = selection; self.count = count
    }
    public var body: some View {
        let model = WardoPageWindow(count: count, selection: selection)
        HStack(spacing: 12) {
            ForEach(model.pages, id: \.self) { page in
                let selected = page == model.selection
                Capsule().fill((selected ? WardoColorToken.backgroundRaised : .textSecondary).color(in: theme))
                    .frame(width: selected ? 16 : model.diameter(for: page), height: 8)
                    .overlay(alignment: .leading) {
                        if selected { Circle().fill(WardoColorToken.textBrand.color(in: theme)).frame(width: 8, height: 8) }
                    }
            }
        }
        .padding(.vertical, 10).frame(minWidth: 60, minHeight: 60)
        .contentShape(Rectangle())
        .overlay {
            GeometryReader { geometry in
                Color.clear.contentShape(Rectangle()).onTapGesture { point in
                    guard isEnabled else { return }
                    let x = direction == .rightToLeft ? geometry.size.width - point.x : point.x
                    selection = model.page(at: x, width: geometry.size.width)
                }
            }
        }
        .opacity(isEnabled ? 1 : 0.5)
        .focusable(isEnabled)
        .onKeyPress(.leftArrow) { move(direction == .rightToLeft ? 1 : -1); return .handled }
        .onKeyPress(.rightArrow) { move(direction == .rightToLeft ? -1 : 1); return .handled }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(label))
        .accessibilityValue(Text("Page \(model.selection + 1) of \(count)"))
        .accessibilityAdjustableAction { action in
            switch action { case .increment: move(1); case .decrement: move(-1); @unknown default: break }
        }
    }
    private func move(_ delta: Int) {
        guard isEnabled else { return }
        selection = WardoPageWindow(count: count, selection: selection).advanced(by: delta)
    }
}

/// Keeps arbitrarily large document collections bounded without losing the
/// selected page. The smaller edge indicators communicate off-screen pages.
struct WardoPageWindow {
    let count: Int
    let selection: Int
    let pages: Range<Int>
    init(count: Int, selection: Int) {
        precondition(count > 0)
        self.count = count
        self.selection = min(max(selection, 0), count - 1)
        let start = min(max(self.selection - 3, 0), max(count - 8, 0))
        pages = start..<min(start + 8, count)
    }
    func diameter(for page: Int) -> CGFloat {
        if page == selection { return 8 }
        if (pages.lowerBound > 0 && page == pages.lowerBound) || (pages.upperBound < count && page == pages.upperBound - 1) { return 4 }
        if (pages.lowerBound > 0 && page == pages.lowerBound + 1) || (pages.upperBound < count && page == pages.upperBound - 2) { return 6 }
        return 8
    }
    func advanced(by delta: Int) -> Int {
        if delta > 0 { return selection == count - 1 ? selection : selection + 1 }
        if delta < 0 { return selection == 0 ? 0 : selection - 1 }
        return selection
    }
    func page(at x: CGFloat, width: CGFloat) -> Int {
        guard x.isFinite, width.isFinite, width > 0 else { return selection }
        let widths = pages.map { $0 == selection ? CGFloat(16) : diameter(for: $0) }
        let total = widths.reduce(0, +) + CGFloat(max(pages.count - 1, 0)) * 12
        var center = (width - total) / 2
        var closest = selection
        var distance = CGFloat.infinity
        for (offset, page) in pages.enumerated() {
            let candidate = abs(x - (center + widths[offset] / 2))
            if candidate < distance { closest = page; distance = candidate }
            center += widths[offset] + 12
        }
        return closest
    }
}
