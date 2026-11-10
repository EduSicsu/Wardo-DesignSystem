import SwiftUI

/// A compact section scrubber. Navigation remains owned by the application.
/// The optional selection binding follows external section changes; the original
/// sections/navigate initializer remains supported.
public struct WardoIndexBar: View {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.layoutDirection) private var direction
    @Environment(\.isEnabled) private var enabled
    @ScaledMetric(relativeTo: .caption2) private var barHeight = CGFloat(466)
    @ScaledMetric(relativeTo: .caption2) private var lettersWidth = CGFloat(20)
    @ScaledMetric(relativeTo: .caption2) private var barWidth = CGFloat(44)
    @State private var focusedSection: String?
    @State private var lastScrubbedIndex: Int?
    @State private var pointerInside = false
    @GestureState private var scrubbing = false
    @Namespace private var hoverNamespace
    private let sections: [String]
    private let selection: Binding<String?>?
    private let label: String
    private let navigate: (String) -> Void
    public init(sections: [String], selection: Binding<String?>? = nil, label: String = "Section index", navigate: @escaping (String) -> Void) {
        self.sections = sections; self.selection = selection; self.label = label; self.navigate = navigate
    }
    private var selectedIndex: Int { sections.firstIndex(of: selection?.wrappedValue ?? focusedSection ?? "") ?? 0 }
    public var body: some View {
        if !sections.isEmpty {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ForEach(Array(sections.enumerated()), id: \.offset) { _, section in
                        Text(section).font(WardoFonts.label(12, weight: .semibold, relativeTo: .caption2))
                            .lineLimit(1).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: direction == .rightToLeft ? .leading : .center)
                    }
                }
                .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
                .padding(.vertical, 4).frame(width: lettersWidth, height: geometry.size.height)
                .background {
                    Capsule().fill(WardoColorToken.backgroundRaised.color(in: theme))
                        #if os(visionOS)
                        .hoverEffect { effect, active, _ in effect.opacity(active && enabled ? 1 : 0) }
                        #else
                        .opacity(pointerInside && enabled ? 1 : 0)
                        #endif
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .gesture(DragGesture(minimumDistance: 0).updating($scrubbing) { _, state, _ in state = true }.onChanged { gesture in
                    guard enabled, let index = WardoIndexPosition.index(at: gesture.location.y, height: geometry.size.height, count: sections.count), lastScrubbedIndex != index else { return }
                    lastScrubbedIndex = index
                    choose(index)
                }.onEnded { _ in lastScrubbedIndex = nil })
            }
            .frame(width: max(44, barWidth), height: barHeight)
            .opacity(enabled ? 1 : 0.45)
            .onChange(of: scrubbing) { _, active in if !active { lastScrubbedIndex = nil } }
            .onChange(of: sections) { _, _ in lastScrubbedIndex = nil }
            #if os(visionOS)
            .hoverEffect { effect, _, _ in effect.opacity(1) }
            .hoverEffectGroup(in: hoverNamespace)
            #else
            .onHover { pointerInside = $0 }
            #endif
            .focusable(enabled)
            .onKeyPress(.upArrow) { choose(max(0, selectedIndex - 1)); return .handled }
            .onKeyPress(.downArrow) { choose(min(sections.count - 1, selectedIndex + 1)); return .handled }
            .accessibilityRepresentation {
                Slider(value: Binding(get: { Double(selectedIndex) }, set: { choose(min(sections.count - 1, max(0, Int($0.rounded())))) }), in: 0...Double(max(1, sections.count - 1)), step: 1) { Text(label) }
                    .accessibilityValue(Text(sections[selectedIndex])).disabled(!enabled)
            }
        }
    }
    private func choose(_ index: Int) {
        guard enabled, sections.indices.contains(index) else { return }
        let section = sections[index]
        focusedSection = section
        selection?.wrappedValue = section
        navigate(section)
    }
}

enum WardoIndexPosition {
    static func index(at y: CGFloat, height: CGFloat, count: Int) -> Int? {
        guard count > 0, y.isFinite, height.isFinite, height > 8 else { return nil }
        let fraction = min(1, max(0, (y - 4) / (height - 8)))
        if fraction == 1 { return count - 1 }
        return min(count - 1, Int(fraction * CGFloat(count)))
    }
}
