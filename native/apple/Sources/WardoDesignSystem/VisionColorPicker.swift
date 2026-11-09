import SwiftUI

/// An sRGB value that can be shared with application state without platform color conversions.
public struct WardoRGBA: Equatable, Hashable, Sendable {
    public var red: Double { didSet { red = Self.clamp(red) } }
    public var green: Double { didSet { green = Self.clamp(green) } }
    public var blue: Double { didSet { blue = Self.clamp(blue) } }
    public var opacity: Double { didSet { opacity = Self.clamp(opacity) } }
    public init(red: Double, green: Double, blue: Double, opacity: Double = 1) {
        self.red = Self.clamp(red); self.green = Self.clamp(green); self.blue = Self.clamp(blue); self.opacity = Self.clamp(opacity)
    }
    private static func clamp(_ value: Double) -> Double { value.isFinite ? min(1, max(0, value)) : 0 }
    public init?(hex: String) {
        let value = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        guard [6, 8].contains(value.count), value.allSatisfy({ $0.isHexDigit }), let integer = UInt64(value, radix: 16) else { return nil }
        let rgb = value.count == 8 ? integer >> 8 : integer
        self.init(red: Double((rgb >> 16) & 255) / 255, green: Double((rgb >> 8) & 255) / 255, blue: Double(rgb & 255) / 255, opacity: value.count == 8 ? Double(integer & 255) / 255 : 1)
    }
    public var hex: String { String(format: "%02X%02X%02X", Int(Self.clamp(red) * 255 + 0.5), Int(Self.clamp(green) * 255 + 0.5), Int(Self.clamp(blue) * 255 + 0.5)) }
    public var color: Color { Color(.sRGB, red: Self.clamp(red), green: Self.clamp(green), blue: Self.clamp(blue), opacity: Self.clamp(opacity)) }
    public static func spectrum(hue: Double, saturation: Double, brightness: Double = 1, opacity: Double = 1) -> Self {
        let h = clamp(hue) * 6
        let s = clamp(saturation), v = clamp(brightness)
        let c = v * s, x = c * (1 - abs(h.truncatingRemainder(dividingBy: 2) - 1)), m = v - c
        let channels: (Double, Double, Double)
        switch Int(h) % 6 { case 0: channels = (c,x,0); case 1: channels = (x,c,0); case 2: channels = (0,c,x); case 3: channels = (0,x,c); case 4: channels = (x,0,c); default: channels = (c,0,x) }
        return Self(red: channels.0 + m, green: channels.1 + m, blue: channels.2 + m, opacity: opacity)
    }
}
public enum WardoColorPickerTab: String, CaseIterable, Sendable { case grid = "Grid", spectrum = "Spectrum", sliders = "Sliders" }

public struct WardoVisionColorPicker: View {
    @Environment(\.wardoTheme) private var theme
    @Binding private var selection: WardoRGBA
    @Binding private var swatches: [WardoRGBA]
    @State private var tab: WardoColorPickerTab
    @State private var hex = ""
    @State private var hexError = false
    @State private var hue = 0.0
    @State private var saturation = 0.5
    @GestureState private var spectrumDragging = false
    private let supportsOpacity: Bool
    private let close: () -> Void
    public init(selection: Binding<WardoRGBA>, swatches: Binding<[WardoRGBA]>, initialTab: WardoColorPickerTab = .grid, supportsOpacity: Bool = true, onClose: @escaping () -> Void) {
        _selection = selection; _swatches = swatches; _tab = State(initialValue: initialTab); self.supportsOpacity = supportsOpacity; close = onClose
    }
    private var surface: Color { WardoColorToken.backgroundRaised.color(in: theme) }
    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: close) { Image(systemName: "xmark").frame(width: 44, height: 44) }.buttonStyle(.plain).background(surface, in: Circle()).accessibilityLabel("Close color picker")
                Text("Color").font(WardoFonts.label(20)).frame(maxWidth: .infinity)
                Color.clear.frame(width: 44, height: 44).accessibilityHidden(true)
            }.padding(.bottom, 8)
            Picker("Color selection method", selection: $tab) { ForEach(WardoColorPickerTab.allCases, id: \.self) { Text($0.rawValue).tag($0) } }.pickerStyle(.segmented).frame(minHeight: 44)
            Group {
                switch tab {
                case .grid: grid
                case .spectrum: spectrum
                case .sliders: channels
                }
            }.frame(minHeight: 300)
            if supportsOpacity { channel("Opacity", value: $selection.opacity, colors: [selection.color.opacity(0), selection.color.opacity(1)], percent: true) }
            HStack(alignment: .top, spacing: 20) {
                RoundedRectangle(cornerRadius: 24).fill(selection.color).frame(width: 104, height: 104).overlay { RoundedRectangle(cornerRadius: 24).stroke(.primary.opacity(0.12)) }.accessibilityLabel("Selected color #\(selection.hex)")
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                    ForEach(Array(swatches.enumerated()), id: \.offset) { _, swatch in
                        Button { selection = swatch } label: { Circle().fill(swatch.color).frame(width: 44, height: 44).padding(2).overlay { Circle().stroke(selection == swatch ? selection.color : .clear, lineWidth: 3) } }.buttonStyle(.plain).accessibilityLabel("Color #\(swatch.hex)").accessibilityValue("Opacity \(Int((swatch.opacity * 100).rounded()))%").accessibilityAddTraits(selection == swatch ? [.isSelected] : [])
                    }
                    Button { if !swatches.contains(selection) { swatches.append(selection) } } label: { Image(systemName: "plus").frame(width: 44, height: 44) }.buttonStyle(.plain).background(surface.opacity(0.6), in: Circle()).accessibilityLabel("Save selected color")
                }
            }
        }
        .padding(24).frame(idealWidth: 408, maxWidth: 408)
        .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 48))
        .overlay { RoundedRectangle(cornerRadius: 48).stroke(.white.opacity(0.4)) }
        .onAppear { hex = selection.hex; synchronizeSpectrum() }
        .onChange(of: tab) { _, value in if value == .spectrum { synchronizeSpectrum() } }
        .onChange(of: selection) { _, value in hex = value.hex; hexError = false; if tab == .spectrum && !spectrumDragging { synchronizeSpectrum() } }
    }
    private var grid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 12), spacing: 0) {
            ForEach(Array(WardoColorPalette.grid.enumerated()), id: \.offset) { _, swatch in
                Button { selection = WardoRGBA(red: swatch.red, green: swatch.green, blue: swatch.blue, opacity: selection.opacity) } label: {
                    Rectangle().fill(swatch.color).aspectRatio(1, contentMode: .fit).overlay { if swatch.hex == selection.hex { RoundedRectangle(cornerRadius: 2).stroke(.white, lineWidth: 3).padding(1) } }
                }.buttonStyle(.plain).accessibilityLabel("Color #\(swatch.hex)").accessibilityAddTraits(selection.hex == swatch.hex ? [.isSelected] : [])
            }
        }.clipShape(RoundedRectangle(cornerRadius: 16))
    }
    private var channels: some View {
        VStack(spacing: 20) {
            channel("Red", value: $selection.red, colors: [WardoRGBA(red: 0, green: selection.green, blue: selection.blue).color, WardoRGBA(red: 1, green: selection.green, blue: selection.blue).color])
            channel("Green", value: $selection.green, colors: [WardoRGBA(red: selection.red, green: 0, blue: selection.blue).color, WardoRGBA(red: selection.red, green: 1, blue: selection.blue).color])
            channel("Blue", value: $selection.blue, colors: [WardoRGBA(red: selection.red, green: selection.green, blue: 0).color, WardoRGBA(red: selection.red, green: selection.green, blue: 1).color])
            HStack {
                Text("RGB Hex Color #").font(WardoFonts.label(14))
                TextField("RGB Hex Color", text: $hex).textFieldStyle(.roundedBorder).frame(maxWidth: 110).onSubmit {
                    let input = hex.trimmingCharacters(in: .whitespacesAndNewlines)
                    let rgb = input.hasPrefix("#") ? String(input.dropFirst()) : input
                    if rgb.count == 6, var color = WardoRGBA(hex: rgb) { color.opacity = selection.opacity; selection = color; hexError = false }
                    else { hexError = true; AccessibilityNotification.Announcement("Invalid color. Enter six hexadecimal digits.").post() }
                }
            }
            if hexError { Text("Enter six hexadecimal digits.").foregroundStyle(.red).accessibilityLabel("Invalid color. Enter six hexadecimal digits.") }
        }
    }
    private var spectrum: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Image("spectrum", bundle: .module).resizable().frame(width: geometry.size.width, height: 300).clipShape(RoundedRectangle(cornerRadius: 16))
                Circle().fill(selection.color).overlay { Circle().stroke(.white, lineWidth: 2) }.frame(width: 32, height: 32)
                    .position(x: saturation * geometry.size.width, y: hue * 300)
            }.contentShape(RoundedRectangle(cornerRadius: 16))
                .gesture(DragGesture(minimumDistance: 0).updating($spectrumDragging) { _, state, _ in state = true }.onChanged { gesture in
                    saturation = min(1, max(0, gesture.location.x / max(1, geometry.size.width)))
                    hue = min(1, max(0, gesture.location.y / 300)); updateSpectrum()
                })
                .accessibilityRepresentation {
                    VStack {
                        Slider(value: Binding(get: { hue }, set: { hue = $0; updateSpectrum() }), in: 0...1) { Text("Hue") }
                        Slider(value: Binding(get: { saturation }, set: { saturation = $0; updateSpectrum() }), in: 0...1) { Text("Tone") }
                    }
                }
        }.frame(height: 300)
    }
    private func synchronizeSpectrum() { let point = WardoSpectrumSampler.nearestPoint(to: selection); saturation = point.x; hue = point.y }
    private func updateSpectrum() { if let color = WardoSpectrumSampler.color(at: CGPoint(x: saturation, y: hue), opacity: selection.opacity) { selection = color } }
    private func channel(_ title: String, value: Binding<Double>, colors: [Color], percent: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(WardoFonts.label(14))
            HStack(spacing: 16) {
                WardoVisionSlider(title, value: value, step: percent ? 0.01 : 1.0 / 255, appearance: .color, colors: colors)
                HStack(spacing: 2) {
                    TextField(title, value: Binding(get: { value.wrappedValue * (percent ? 100 : 255) }, set: { proposed in
                        guard proposed.isFinite else { return }
                        value.wrappedValue = min(1, max(0, proposed.rounded() / (percent ? 100 : 255)))
                    }), format: .number.precision(.fractionLength(0)))
                    .multilineTextAlignment(.trailing).accessibilityLabel("\(title) value")
                    if percent { Text("%").accessibilityHidden(true) }
                }.font(WardoFonts.label(14)).monospacedDigit().padding(.horizontal, 12).frame(width: 88, height: 44).background(.primary.opacity(0.12), in: Capsule())
            }
        }
    }
}
