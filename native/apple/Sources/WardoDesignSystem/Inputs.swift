import SwiftUI

public enum WardoFieldShape: Sendable { case roundedRect, pill }

public struct WardoTextField: View {
    @Environment(\.wardoTheme) private var theme
    @Binding private var text: String
    private let title: String
    private let secure: Bool
    private let multiline: Bool
    private let shape: WardoFieldShape
    private let clearable: Bool
    private let leadingSystemImage: String?
    public init(_ title: String, text: Binding<String>, secure: Bool = false, multiline: Bool = false, shape: WardoFieldShape = .roundedRect, clearable: Bool = false, leadingSystemImage: String? = nil) {
        self.title = title; _text = text; self.secure = secure; self.multiline = multiline; self.shape = shape; self.clearable = clearable; self.leadingSystemImage = leadingSystemImage
    }
    public var body: some View {
        HStack(spacing: 12) {
            if let leadingSystemImage { Image(systemName: leadingSystemImage).accessibilityHidden(true) }
            Group {
                if secure { SecureField(title, text: $text) }
                else if multiline { TextField(title, text: $text, axis: .vertical).lineLimit(3...8) }
                else { TextField(title, text: $text) }
            }.accessibilityLabel(title)
            if clearable && !text.isEmpty {
                Button { text = "" } label: { Image(systemName: "xmark").frame(minWidth: 44, minHeight: 44) }.buttonStyle(.plain).accessibilityLabel("Clear \(title)")
            }
        }
        .textFieldStyle(.plain).font(WardoFonts.body())
        .padding(.horizontal, 16).padding(.vertical, multiline ? 12 : 0).frame(minHeight: 44)
        .background(WardoColorToken.backgroundRaised.color(in: theme), in: RoundedRectangle(cornerRadius: shape == .pill ? 100 : 12))
        .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
    }
}

public struct WardoSearchField: View {
    @Binding private var text: String
    private let title: String
    private let submit: () -> Void
    public init(_ title: String, text: Binding<String>, onSubmit: @escaping () -> Void) { self.title = title; _text = text; submit = onSubmit }
    public var body: some View { WardoTextField(title, text: $text, shape: .pill, clearable: true, leadingSystemImage: "magnifyingglass").onSubmit(submit).submitLabel(.search) }
}

public struct WardoToggle: View {
    @Environment(\.wardoTheme) private var theme
    @Binding private var isOn: Bool
    private let title: String
    public init(_ title: String, isOn: Binding<Bool>) { self.title = title; _isOn = isOn }
    public var body: some View { Toggle(title, isOn: $isOn).tint(WardoColorToken.actionPrimary.color(in: theme)).font(WardoFonts.label()) }
}

public struct WardoVisionToggleStyle: ToggleStyle {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.isEnabled) private var enabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        Button { configuration.isOn.toggle() } label: {
            HStack {
                configuration.label
                Spacer()
                Capsule().fill((configuration.isOn ? WardoColorToken.backgroundBrand : .backgroundRaised).color(in: theme))
                    .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                        Circle().fill(WardoColorToken.textPrimary.color(in: theme)).frame(width: 28, height: 28).padding(2)
                    }.frame(width: 56, height: 32)
                    .animation(reduceMotion ? nil : .easeOut(duration: 0.15), value: configuration.isOn)
                    .accessibilityHidden(true)
            }.frame(maxWidth: .infinity, minHeight: 44).contentShape(Rectangle())
        }.buttonStyle(.plain).opacity(enabled ? 1 : 0.45)
        .accessibilityRepresentation { Toggle(isOn: configuration.$isOn) { configuration.label } }
    }
}

public struct WardoCheckbox: View {
    @Binding private var isOn: Bool
    private let title: String
    public init(_ title: String, isOn: Binding<Bool>) { self.title = title; _isOn = isOn }
    public var body: some View {
        Toggle(title, isOn: $isOn)
            #if os(macOS)
            .toggleStyle(.checkbox)
            #else
            .toggleStyle(WardoVisionCheckboxStyle())
            #endif
    }
}

public struct WardoSegmentedControl<Selection: Hashable, Items: View>: View {
    @Binding private var selection: Selection
    private let title: String
    private let items: Items
    public init(_ title: String, selection: Binding<Selection>, @ViewBuilder items: () -> Items) { self.title = title; _selection = selection; self.items = items() }
    public var body: some View { Picker(title, selection: $selection) { items }.pickerStyle(.segmented).font(WardoFonts.label()) }
}

public struct WardoSlider: View {
    @Environment(\.wardoTheme) private var theme
    @Binding private var value: Double
    private let range: ClosedRange<Double>
    private let step: Double
    private let title: String
    public init(_ title: String, value: Binding<Double>, in range: ClosedRange<Double> = 0...1, step: Double = 0.01) {
        precondition(step > 0); self.title = title; _value = value; self.range = range; self.step = step
    }
    public var body: some View { Slider(value: $value, in: range, step: step) { Text(title) }.tint(WardoColorToken.actionPrimary.color(in: theme)) }
}

public struct WardoStepper: View {
    @Binding private var value: Int
    private let title: String
    private let range: ClosedRange<Int>
    public init(_ title: String, value: Binding<Int>, in range: ClosedRange<Int>) { self.title = title; _value = value; self.range = range }
    public var body: some View { Stepper(value: $value, in: range) { Text(title); Text(value, format: .number).monospacedDigit() } }
}

public enum WardoDatePickerPresentation: Sendable { case compact, expanded, wheels }
public struct WardoDatePicker: View {
    @Binding private var selection: Date
    private let title: String
    private let components: DatePickerComponents
    private let presentation: WardoDatePickerPresentation
    public init(_ title: String, selection: Binding<Date>, displayedComponents: DatePickerComponents = [.date], presentation: WardoDatePickerPresentation = .compact) {
        self.title = title; _selection = selection; components = displayedComponents; self.presentation = presentation
    }
    public var body: some View {
        switch presentation {
        case .expanded: DatePicker(title, selection: $selection, displayedComponents: components).datePickerStyle(.graphical)
        case .wheels:
            #if os(iOS) || os(visionOS)
            DatePicker(title, selection: $selection, displayedComponents: components).datePickerStyle(.wheel)
            #else
            DatePicker(title, selection: $selection, displayedComponents: components)
            #endif
        case .compact: DatePicker(title, selection: $selection, displayedComponents: components).datePickerStyle(.compact)
        }
    }
}

public struct WardoColorPicker: View {
    @Binding private var selection: Color
    private let title: String
    private let supportsOpacity: Bool
    public init(_ title: String, selection: Binding<Color>, supportsOpacity: Bool = true) { self.title = title; _selection = selection; self.supportsOpacity = supportsOpacity }
    public var body: some View { ColorPicker(title, selection: $selection, supportsOpacity: supportsOpacity) }
}

/// Circular visionOS checkbox with native Toggle accessibility and a 44-point interaction region.
public struct WardoVisionCheckboxStyle: ToggleStyle {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.isEnabled) private var enabled
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        Button { configuration.isOn.toggle() } label: {
            HStack(spacing: 8) {
                ZStack {
                    Circle().fill((configuration.isOn ? WardoColorToken.backgroundBrand : .backgroundRaised).color(in: theme))
                    if configuration.isOn { Image(systemName: "checkmark").font(.system(size: 16, weight: .semibold)).foregroundStyle(WardoColorToken.textPrimary.color(in: theme)) }
                    else { Circle().stroke(WardoColorToken.borderDefault.color(in: theme), lineWidth: 2) }
                }.frame(width: 28, height: 28).frame(minWidth: 44, minHeight: 44)
                configuration.label
            }.frame(maxWidth: .infinity, minHeight: 44, alignment: .leading).contentShape(Rectangle())
        }.buttonStyle(.plain).opacity(enabled ? 1 : 0.45)
            .accessibilityRepresentation { Toggle(isOn: configuration.$isOn) { configuration.label } }
            #if !os(macOS)
            .hoverEffect(.highlight)
            #endif
    }
}

public struct WardoTimePicker: View {
    @Binding private var selection: Date
    private let title: String
    private let presentation: WardoDatePickerPresentation
    public init(_ title: String, selection: Binding<Date>, presentation: WardoDatePickerPresentation = .compact) { self.title = title; _selection = selection; self.presentation = presentation }
    public var body: some View { WardoDatePicker(title, selection: $selection, displayedComponents: .hourAndMinute, presentation: presentation) }
}
