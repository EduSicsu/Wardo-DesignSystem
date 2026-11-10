import SwiftUI

/// Wardo's native-derived sidebar search atom. The application owns the query,
/// submission and voice-search flow; this view never requests microphone access.
public struct WardoSidebarSearchField: View {
    @Environment(\.wardoTheme) private var theme
    @Environment(\.layoutDirection) private var direction
    @Environment(\.isEnabled) private var isEnabled
    @FocusState private var isFocused: Bool
    @Binding private var text: String
    private let title: String
    private let voiceSearchLabel: String
    private let onSubmit: () -> Void
    private let onVoiceSearch: () -> Void

    public init(
        _ title: String,
        text: Binding<String>,
        voiceSearchLabel: String = "Voice search",
        onSubmit: @escaping () -> Void,
        onVoiceSearch: @escaping () -> Void
    ) {
        self.title = title
        _text = text
        self.voiceSearchLabel = voiceSearchLabel
        self.onSubmit = onSubmit
        self.onVoiceSearch = onVoiceSearch
    }

    public var body: some View {
        HStack(spacing: 8) {
            Image(decorative: direction == .rightToLeft ? "WardoSidebarSearchRTL" : "WardoSidebarSearchLTR", bundle: .module)
                .renderingMode(.template)
                .frame(width: 21, height: 22)
                .accessibilityHidden(true)
            TextField(title, text: $text, prompt: Text(title).foregroundStyle(WardoColorToken.textSecondary.color(in: theme)))
                .textFieldStyle(.plain)
                .accessibilityLabel(title)
                .focused($isFocused)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .onSubmit {
                    isFocused = false
                    onSubmit()
                }
            Button(action: onVoiceSearch) {
                Image(decorative: "WardoSidebarMicrophone", bundle: .module)
                    .renderingMode(.template)
                    .frame(width: 17, height: 22)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(voiceSearchLabel)
        }
        .font(WardoFonts.label(17, weight: .regular))
        .foregroundStyle(WardoColorToken.textSecondary.color(in: theme))
        .padding(.leading, 11)
        .padding(.vertical, 1)
        .frame(minHeight: 46)
        .background(WardoColorToken.backgroundRaised.color(in: theme), in: Capsule())
        .opacity(isEnabled ? 1 : 0.45)
    }
}
