import SwiftUI
import CoreText

public enum WardoTheme: String, CaseIterable, Sendable {
    case wardoLight = "Wardo Light", wardoDark = "Wardo Dark"
    case oceanLight = "Ocean Light", oceanDark = "Ocean Dark"
    case orchidLight = "Orchid Light", orchidDark = "Orchid Dark"
    case emberLight = "Ember Light", emberDark = "Ember Dark"
    case cloudLight = "Cloud Light", cloudDark = "Cloud Dark"
}

private struct WardoThemeKey: EnvironmentKey { static let defaultValue = WardoTheme.wardoLight }
public extension EnvironmentValues {
    var wardoTheme: WardoTheme {
        get { self[WardoThemeKey.self] }
        set { self[WardoThemeKey.self] = newValue }
    }
}
public extension View {
    func wardoTheme(_ theme: WardoTheme) -> some View {
        environment(\.wardoTheme, theme)
            .preferredColorScheme(theme.rawValue.hasSuffix("Dark") ? .dark : .light)
    }
}

public enum WardoFonts {
    private static let registered: Void = {
        for name in ["Geologica", "SourceSerif4"] {
            if let url = Bundle.module.url(forResource: name, withExtension: "ttf", subdirectory: "Fonts") ?? Bundle.module.url(forResource: name, withExtension: "ttf") {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            }
        }
    }()
    public static func label(_ size: CGFloat = 17, weight: Font.Weight = .semibold, relativeTo: Font.TextStyle = .body) -> Font {
        _ = registered
        return .custom("Geologica-Thin", size: size, relativeTo: relativeTo).weight(weight)
    }
    public static func body(_ size: CGFloat = 17) -> Font {
        _ = registered
        return .custom("SourceSerif4Roman-Regular", size: size, relativeTo: .body)
    }
}
