import SwiftUI

/// Endpoint content remains application owned. Decorative labels do not create
/// duplicate accessibility elements; the slider announces its title and value.
public struct WardoVisionLabeledSlider<Minimum: View, Maximum: View>: View {
    @Binding private var value: Double
    private let title: String
    private let range: ClosedRange<Double>
    private let step: Double
    private let size: WardoVisionSliderSize
    private let appearance: WardoVisionSliderAppearance
    private let segmentCount: Int
    private let editing: (Bool) -> Void
    private let minimum: Minimum
    private let maximum: Maximum
    public init(_ title: String, value: Binding<Double>, in range: ClosedRange<Double> = 0...1, step: Double = 0.01, size: WardoVisionSliderSize = .large, appearance: WardoVisionSliderAppearance = .filled, segmentCount: Int = 4, onEditingChanged: @escaping (Bool) -> Void = { _ in }, @ViewBuilder minimumValueLabel: () -> Minimum, @ViewBuilder maximumValueLabel: () -> Maximum) {
        self.title = title; _value = value; self.range = range; self.step = step; self.size = size
        self.appearance = appearance; self.segmentCount = segmentCount; self.editing = onEditingChanged
        self.minimum = minimumValueLabel(); self.maximum = maximumValueLabel()
    }
    public var body: some View {
        HStack(spacing: 12) {
            minimum.fixedSize().accessibilityHidden(true)
            WardoVisionSlider(title, value: $value, in: range, step: step, size: size, appearance: appearance, segmentCount: segmentCount, onEditingChanged: editing)
            maximum.fixedSize().accessibilityHidden(true)
        }
    }
}
