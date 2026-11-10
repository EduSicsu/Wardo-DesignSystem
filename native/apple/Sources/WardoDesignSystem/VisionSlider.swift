import SwiftUI

public enum WardoVisionSliderSize: CaseIterable, Hashable, Sendable { case mini, small, regular, large
    var height: CGFloat { switch self { case .mini: 12; case .small: 16; case .regular: 28; case .large: 44 } }
    var stopDiameter: Int { switch self { case .mini: 3; case .small: 4; case .regular: 6; case .large: 8 } }
    var segmentKnobDiameter: CGFloat { switch self { case .mini: 8; case .small: 12; case .regular: 20; case .large: 36 } }
    var segmentInset: CGFloat { switch self { case .mini: 5.5; case .small: 8; case .regular: 14; case .large: 22 } }
}
public enum WardoVisionSliderAppearance: Sendable { case filled, segmented, color }

/// Filled-track Wardo slider. Its binding, accessibility adjustments and drag gestures share one value model.
public struct WardoVisionSlider<Symbol: View>: View {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.layoutDirection) private var direction
    @Environment(\.isEnabled) private var enabled
    @Binding private var value: Double
    @GestureState private var dragging = false
    private let title: String
    private let range: ClosedRange<Double>
    private let step: Double
    private let size: WardoVisionSliderSize
    private let appearance: WardoVisionSliderAppearance
    private let colors: [Color]
    private let symbol: Symbol
    private let segmentCount: Int
    private let editing: (Bool) -> Void
    public init(_ title: String, value: Binding<Double>, in range: ClosedRange<Double> = 0...1, step: Double = 0.01, size: WardoVisionSliderSize = .large, appearance: WardoVisionSliderAppearance = .filled, colors: [Color] = [], segmentCount: Int = 4, onEditingChanged: @escaping (Bool) -> Void = { _ in }, @ViewBuilder symbol: () -> Symbol) {
        precondition(range.lowerBound.isFinite && range.upperBound.isFinite && range.lowerBound < range.upperBound && step.isFinite && step > 0)
        precondition((1...100).contains(segmentCount))
        self.title = title; _value = value; self.range = range; self.step = appearance == .segmented ? (range.upperBound - range.lowerBound) / Double(segmentCount) : step; self.size = size; self.appearance = appearance; self.colors = colors; self.segmentCount = segmentCount; self.editing = onEditingChanged; self.symbol = symbol()
    }
    private var fraction: Double {
        guard value.isFinite else { return 0 }
        let displayed = appearance == .segmented ? Self.quantized(value, in: range, step: step) : min(range.upperBound, max(range.lowerBound, value))
        return (displayed - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    private func update(_ proposed: Double) { value = Self.quantized(proposed, in: range, step: step) }
    nonisolated public static func quantized(_ value: Double, in range: ClosedRange<Double>, step: Double) -> Double {
        guard value.isFinite, step.isFinite, step > 0 else { return range.lowerBound }
        return min(range.upperBound, max(range.lowerBound, range.lowerBound + ((value - range.lowerBound) / step).rounded() * step))
    }
    public var body: some View {
        GeometryReader { geometry in
            let height = size.height
            let inset = appearance == .segmented ? size.segmentInset : height / 2
            let track = max(0, geometry.size.width - 2 * inset)
            let offset = CGFloat(fraction) * track
            let knob = appearance == .color ? min(dragging ? CGFloat(24) : 32, max(4, height - 12)) : appearance == .segmented ? size.segmentKnobDiameter : max(4, height - 8)
            ZStack(alignment: .leading) {
                Capsule().fill(WardoColorToken.backgroundRaised.color(in: theme))
                if appearance == .color {
                    Capsule().fill(LinearGradient(colors: colors.isEmpty ? [.red, .blue] : colors, startPoint: .leading, endPoint: .trailing))
                } else if appearance == .filled {
                    Capsule().fill(WardoColorToken.textBrand.color(in: theme)).frame(width: height + offset)
                        .shadow(color: .black.opacity(0.18), radius: 4, x: 5)
                }
                if appearance == .segmented {
                    ForEach(0...segmentCount, id: \.self) { index in
                        Image("stop-\(size.stopDiameter)", bundle: .module).renderingMode(.template)
                            .foregroundStyle(WardoColorToken.backgroundRaised.color(in: theme))
                            .frame(width: CGFloat(size.stopDiameter), height: CGFloat(size.stopDiameter))
                            .offset(x: (inset - CGFloat(size.stopDiameter) / 2 + CGFloat(index) * track / CGFloat(segmentCount)) * (direction == .leftToRight ? 1 : -1))
                    }
                }
                symbol.padding(.horizontal, 12).accessibilityHidden(true)
                if dragging || appearance == .color || appearance == .segmented {
                    Circle().fill(appearance == .color ? Color.clear : WardoColorToken.textPrimary.color(in: theme))
                        .overlay { Circle().stroke(.white, lineWidth: appearance == .color ? 3 : 0) }
                        .frame(width: knob, height: knob)
                        #if os(visionOS)
                        .hoverEffect { effect, active, _ in
                            effect.scaleEffect(active && enabled && appearance == .color && !dragging ? 1.125 : 1)
                        }
                        #endif
                        .offset(x: (inset - knob / 2 + offset) * (direction == .leftToRight ? 1 : -1))
                        .shadow(color: .white.opacity(dragging ? 0.2 : 0), radius: 10)
                }
            }
            .clipShape(Capsule()).overlay { Capsule().stroke(.primary.opacity(0.1), lineWidth: 1) }
            .frame(height: height)
            .frame(maxHeight: .infinity)
            .contentShape(Rectangle())
            .simultaneousGesture(DragGesture(minimumDistance: 8).updating($dragging) { gesture, state, _ in state = abs(gesture.translation.width) >= abs(gesture.translation.height) }.onChanged { gesture in
                guard enabled, track > 0, abs(gesture.translation.width) >= abs(gesture.translation.height) else { return }
                let location = direction == .leftToRight ? gesture.location.x : geometry.size.width - gesture.location.x
                update(range.lowerBound + Double(min(track, max(0, location - inset)) / track) * (range.upperBound - range.lowerBound))
            })
            .onTapGesture(coordinateSpace: .local) { point in
                guard enabled, track > 0 else { return }
                let location = direction == .leftToRight ? point.x : geometry.size.width - point.x
                editing(true)
                update(range.lowerBound + Double(min(track, max(0, location - inset)) / track) * (range.upperBound - range.lowerBound))
                editing(false)
            }
            .onChange(of: dragging) { _, active in editing(active) }
            #if !os(macOS)
            .hoverEffect(.highlight)
            #endif
        }
        .frame(minWidth: 88, minHeight: max(44, size.height), maxHeight: max(44, size.height))
        .opacity(enabled ? 1 : 0.45)
        .focusable(enabled)
        .onKeyPress(.leftArrow) { adjust(direction == .leftToRight ? -1 : 1); return .handled }
        .onKeyPress(.rightArrow) { adjust(direction == .leftToRight ? 1 : -1); return .handled }
        .accessibilityRepresentation {
            Slider(value: Binding(get: { range.lowerBound + fraction * (range.upperBound - range.lowerBound) }, set: update), in: range, step: step, onEditingChanged: editing) { Text(title) }
                .accessibilityValue((range.lowerBound + fraction * (range.upperBound - range.lowerBound)).formatted(.number.precision(.fractionLength(0...2))))
                .disabled(!enabled)
        }
    }
    private func adjust(_ direction: Double) {
        guard enabled else { return }
        editing(true)
        update(range.lowerBound + fraction * (range.upperBound - range.lowerBound) + direction * step)
        editing(false)
    }
}
public extension WardoVisionSlider where Symbol == EmptyView {
    init(_ title: String, value: Binding<Double>, in range: ClosedRange<Double> = 0...1, step: Double = 0.01, size: WardoVisionSliderSize = .large, appearance: WardoVisionSliderAppearance = .filled, colors: [Color] = [], segmentCount: Int = 4, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(title, value: value, in: range, step: step, size: size, appearance: appearance, colors: colors, segmentCount: segmentCount, onEditingChanged: onEditingChanged) { EmptyView() }
    }
}
