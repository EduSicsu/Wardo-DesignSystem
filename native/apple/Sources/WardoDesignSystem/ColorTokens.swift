// Generated from the same Figma semantic color snapshot as the web library.
import SwiftUI
public enum WardoColorToken: String, CaseIterable, Sendable {
    case backgroundDefault = "background/default"
    case backgroundRaised = "background/raised"
    case backgroundBrand = "background/brand"
    case textPrimary = "text/primary"
    case textSecondary = "text/secondary"
    case textBrand = "text/brand"
    case borderDefault = "border/default"
    case actionPrimary = "action/primary"
    case actionPrimaryForeground = "action/primary-foreground"
    case backgroundSunken = "background/sunken"
    case backgroundInverse = "background/inverse"
    case backgroundBrandHover = "background/brand-hover"
    case textTertiary = "text/tertiary"
    case textInverse = "text/inverse"
    case textLink = "text/link"
    case borderSubtle = "border/subtle"
    case borderStrong = "border/strong"
    case borderFocus = "border/focus"
    case actionPrimaryHover = "action/primary-hover"
    case actionSecondary = "action/secondary"
    case actionSecondaryForeground = "action/secondary-foreground"
    case stateDisabledBackground = "state/disabled-background"
    case stateDisabledForeground = "state/disabled-foreground"
    case feedbackSuccessBackground = "feedback/success-background"
    case feedbackSuccessForeground = "feedback/success-foreground"
    case feedbackErrorBackground = "feedback/error-background"
    case feedbackErrorForeground = "feedback/error-foreground"
    case feedbackWarningBackground = "feedback/warning-background"
    case feedbackWarningForeground = "feedback/warning-foreground"
    case feedbackInfoBackground = "feedback/info-background"
    case feedbackInfoForeground = "feedback/info-foreground"
    case overlayScrim = "overlay/scrim"
    case overlaySubtle = "overlay/subtle"
    case stateHover = "state/hover"
    case statePressed = "state/pressed"
    case stateSelected = "state/selected"
    case separatorDefault = "separator/default"
    case backgroundSubtle = "background/subtle"
    case textOnBrand = "text/on-brand"
    case backgroundTertiary = "background/tertiary"
    case textOnInverse = "text/on-inverse"
    case actionNeutral = "action/neutral"
    case actionNeutralForeground = "action/neutral-foreground"
    case backgroundMessageReceived = "background/message-received"
    case iconBrand = "icon/brand"
    case textOnMedia = "text/on-media"
    case componentButtonForegroundSecondaryDefaultHover = "component/button/foreground/Secondary/Default/Hover"
    case componentButtonForegroundSecondaryDefaultPressed = "component/button/foreground/Secondary/Default/Pressed"
    case componentButtonForegroundTextDefaultHover = "component/button/foreground/Text/Default/Hover"
    case componentButtonForegroundTextDefaultPressed = "component/button/foreground/Text/Default/Pressed"
    case stateSelectedIndicator = "state/selected-indicator"
    case componentInputFocus = "component/input/focus"
    case textVisionosOnSelected = "text/visionOS/on-selected"
    case cardShadowRaised = "card/shadow-raised"
    case cardShadowFloating = "card/shadow-floating"
    case cardStateHover = "card/state-hover"
    case cardStatePressed = "card/state-pressed"
    case cardStateDragged = "card/state-dragged"
    case codeKeyword = "code/keyword"
    case codeString = "code/string"
    case codeNumber = "code/number"
    case codeFunction = "code/function"
    case codeInverseKeyword = "code/inverse/keyword"
    case codeInverseString = "code/inverse/string"
    case codeInverseNumber = "code/inverse/number"
    case codeInverseFunction = "code/inverse/function"
    case skeletonSurface = "skeleton/surface"
    case cardFilledSurface = "card/filled-surface"
    case cardFilledBorder = "card/filled-border"
    public func color(in theme: WardoTheme) -> Color {
        let rgba: (Double, Double, Double, Double)
        switch self {
        case .backgroundDefault:
            switch theme {
            case .wardoLight: rgba = (0.972549, 0.9490196, 0.9254902, 1.0)
            case .wardoDark: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .oceanLight: rgba = (0.9607843, 0.9686275, 0.9764706, 1.0)
            case .oceanDark: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .orchidLight: rgba = (0.9647059, 0.9647059, 0.9764706, 1.0)
            case .orchidDark: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .emberLight: rgba = (0.9686275, 0.9647059, 0.9686275, 1.0)
            case .emberDark: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .cloudLight: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            case .cloudDark: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            }
        case .backgroundRaised:
            switch theme {
            case .wardoLight: rgba = (0.9372549, 0.9019608, 0.8666667, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .oceanDark: rgba = (0.1372549, 0.1529412, 0.1921569, 1.0)
            case .orchidLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidDark: rgba = (0.145098, 0.1490196, 0.1882353, 1.0)
            case .emberLight: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .emberDark: rgba = (0.1686275, 0.1490196, 0.172549, 1.0)
            case .cloudLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .cloudDark: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            }
        case .backgroundBrand:
            switch theme {
            case .wardoLight: rgba = (0.7294118, 0.8196078, 0.0039216, 1.0)
            case .wardoDark: rgba = (0.9294118, 0.945098, 0.5882353, 1.0)
            case .oceanLight: rgba = (0.9176471, 0.9529412, 1.0, 1.0)
            case .oceanDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            case .orchidLight: rgba = (0.9803922, 0.9294118, 1.0, 1.0)
            case .orchidDark: rgba = (0.1882353, 0.0823529, 0.2745098, 1.0)
            case .emberLight: rgba = (1.0, 0.9137255, 0.8470588, 1.0)
            case .emberDark: rgba = (0.3490196, 0.1137255, 0.0117647, 1.0)
            case .cloudLight: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            case .cloudDark: rgba = (0.2, 0.2, 0.2, 1.0)
            }
        case .textPrimary:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (1.0, 0.9921569, 0.9882353, 1.0)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .textSecondary:
            switch theme {
            case .wardoLight: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .wardoDark: rgba = (0.9372549, 0.9019608, 0.8666667, 1.0)
            case .oceanLight: rgba = (0.1921569, 0.2156863, 0.2705882, 1.0)
            case .oceanDark: rgba = (0.8980392, 0.9137255, 0.9372549, 1.0)
            case .orchidLight: rgba = (0.2078431, 0.2078431, 0.2705882, 1.0)
            case .orchidDark: rgba = (0.9098039, 0.9058824, 0.9372549, 1.0)
            case .emberLight: rgba = (0.2470588, 0.2117647, 0.2431373, 1.0)
            case .emberDark: rgba = (0.9137255, 0.9058824, 0.9137255, 1.0)
            case .cloudLight: rgba = (0.2, 0.2, 0.2, 1.0)
            case .cloudDark: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            }
        case .textBrand:
            switch theme {
            case .wardoLight: rgba = (0.2352941, 0.2666667, 0.0235294, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .borderDefault:
            switch theme {
            case .wardoLight: rgba = (0.3254902, 0.3058824, 0.2823529, 0.6509804)
            case .wardoDark: rgba = (0.9019608, 0.8509804, 0.8, 0.6509804)
            case .oceanLight: rgba = (0.2705882, 0.2980392, 0.3686275, 0.6509804)
            case .oceanDark: rgba = (0.6509804, 0.6862745, 0.7647059, 0.6509804)
            case .orchidLight: rgba = (0.2862745, 0.2901961, 0.3686275, 0.6509804)
            case .orchidDark: rgba = (0.6745098, 0.6745098, 0.7647059, 0.6509804)
            case .emberLight: rgba = (0.3372549, 0.2941176, 0.3333333, 0.6509804)
            case .emberDark: rgba = (0.6980392, 0.6745098, 0.7215686, 0.6509804)
            case .cloudLight: rgba = (0.4627451, 0.4627451, 0.4627451, 0.6509804)
            case .cloudDark: rgba = (0.4627451, 0.4627451, 0.4627451, 0.6509804)
            }
        case .actionPrimary:
            switch theme {
            case .wardoLight: rgba = (0.7294118, 0.8196078, 0.0039216, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.1254902, 0.3803922, 0.7372549, 1.0)
            case .oceanDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .orchidLight: rgba = (0.4823529, 0.2235294, 0.7098039, 1.0)
            case .orchidDark: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .emberLight: rgba = (0.7019608, 0.2666667, 0.0509804, 1.0)
            case .emberDark: rgba = (1.0, 0.6784314, 0.4235294, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .actionPrimaryForeground:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .oceanLight: rgba = (0.9764706, 0.9882353, 1.0, 1.0)
            case .oceanDark: rgba = (0.0156863, 0.0784314, 0.1529412, 1.0)
            case .orchidLight: rgba = (0.9960784, 0.9764706, 1.0, 1.0)
            case .orchidDark: rgba = (0.1294118, 0.0352941, 0.1843137, 1.0)
            case .emberLight: rgba = (1.0, 0.972549, 0.9490196, 1.0)
            case .emberDark: rgba = (0.2039216, 0.0627451, 0.0, 1.0)
            case .cloudLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .cloudDark: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            }
        case .backgroundSunken:
            switch theme {
            case .wardoLight: rgba = (0.9019608, 0.8509804, 0.8, 1.0)
            case .wardoDark: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .oceanLight: rgba = (0.8980392, 0.9137255, 0.9372549, 1.0)
            case .oceanDark: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .orchidLight: rgba = (0.9098039, 0.9058824, 0.9372549, 1.0)
            case .orchidDark: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .emberLight: rgba = (0.9137255, 0.9058824, 0.9137255, 1.0)
            case .emberDark: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .cloudLight: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            case .cloudDark: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            }
        case .backgroundInverse:
            switch theme {
            case .wardoLight: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .wardoDark: rgba = (1.0, 0.9921569, 0.9882353, 1.0)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .backgroundBrandHover:
            switch theme {
            case .wardoLight: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .wardoDark: rgba = (0.2352941, 0.2666667, 0.0235294, 1.0)
            case .oceanLight: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .oceanDark: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .orchidLight: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .orchidDark: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .emberLight: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .emberDark: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .cloudLight: rgba = (0.8235294, 0.8235294, 0.8235294, 1.0)
            case .cloudDark: rgba = (0.2823529, 0.2823529, 0.2823529, 1.0)
            }
        case .textTertiary:
            switch theme {
            case .wardoLight: rgba = (0.3254902, 0.3058824, 0.2823529, 1.0)
            case .wardoDark: rgba = (0.9019608, 0.8509804, 0.8, 1.0)
            case .oceanLight: rgba = (0.2705882, 0.2980392, 0.3686275, 1.0)
            case .oceanDark: rgba = (0.8039216, 0.8313725, 0.8784314, 1.0)
            case .orchidLight: rgba = (0.2862745, 0.2901961, 0.3686275, 1.0)
            case .orchidDark: rgba = (0.8196078, 0.8196078, 0.8784314, 1.0)
            case .emberLight: rgba = (0.3372549, 0.2941176, 0.3333333, 1.0)
            case .emberDark: rgba = (0.8313725, 0.8196078, 0.8431373, 1.0)
            case .cloudLight: rgba = (0.2823529, 0.2823529, 0.2823529, 1.0)
            case .cloudDark: rgba = (0.8235294, 0.8235294, 0.8235294, 1.0)
            }
        case .textInverse:
            switch theme {
            case .wardoLight: rgba = (1.0, 0.9921569, 0.9882353, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .oceanDark: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .orchidLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidDark: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .emberLight: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .emberDark: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .cloudLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .cloudDark: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            }
        case .textLink:
            switch theme {
            case .wardoLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .wardoDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .emberLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .emberDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .cloudLight: rgba = (0.2, 0.2, 0.2, 1.0)
            case .cloudDark: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            }
        case .borderSubtle:
            switch theme {
            case .wardoLight: rgba = (0.5686275, 0.5254902, 0.4823529, 0.5529412)
            case .wardoDark: rgba = (0.3254902, 0.3058824, 0.2823529, 0.5529412)
            case .oceanLight: rgba = (0.8980392, 0.9137255, 0.9372549, 0.5529412)
            case .oceanDark: rgba = (0.1921569, 0.2156863, 0.2705882, 0.5529412)
            case .orchidLight: rgba = (0.9098039, 0.9058824, 0.9372549, 0.5529412)
            case .orchidDark: rgba = (0.2078431, 0.2078431, 0.2705882, 0.5529412)
            case .emberLight: rgba = (0.9137255, 0.9058824, 0.9137255, 0.5529412)
            case .emberDark: rgba = (0.2470588, 0.2117647, 0.2431373, 0.5529412)
            case .cloudLight: rgba = (0.9098039, 0.9098039, 0.9098039, 0.5529412)
            case .cloudDark: rgba = (0.2, 0.2, 0.2, 0.5529412)
            }
        case .borderStrong:
            switch theme {
            case .wardoLight: rgba = (0.1686275, 0.1607843, 0.1490196, 0.5529412)
            case .wardoDark: rgba = (0.9372549, 0.9019608, 0.8666667, 0.5529412)
            case .oceanLight: rgba = (0.1921569, 0.2156863, 0.2705882, 0.5529412)
            case .oceanDark: rgba = (0.8980392, 0.9137255, 0.9372549, 0.5529412)
            case .orchidLight: rgba = (0.2078431, 0.2078431, 0.2705882, 0.5529412)
            case .orchidDark: rgba = (0.9098039, 0.9058824, 0.9372549, 0.5529412)
            case .emberLight: rgba = (0.2470588, 0.2117647, 0.2431373, 0.5529412)
            case .emberDark: rgba = (0.9137255, 0.9058824, 0.9137255, 0.5529412)
            case .cloudLight: rgba = (0.2, 0.2, 0.2, 0.5529412)
            case .cloudDark: rgba = (0.9098039, 0.9098039, 0.9098039, 0.5529412)
            }
        case .borderFocus:
            switch theme {
            case .wardoLight: rgba = (0.4, 0.4509804, 0.0156863, 0.3411765)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 0.3411765)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 0.3411765)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 0.3411765)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 0.3411765)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 0.3411765)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 0.3411765)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 0.3411765)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 0.3411765)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 0.3411765)
            }
        case .actionPrimaryHover:
            switch theme {
            case .wardoLight: rgba = (0.5647059, 0.6352941, 0.0117647, 1.0)
            case .wardoDark: rgba = (0.9294118, 0.945098, 0.5882353, 1.0)
            case .oceanLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.2, 0.2, 0.2, 1.0)
            case .cloudDark: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            }
        case .actionSecondary:
            switch theme {
            case .wardoLight: rgba = (0.8666667, 0.8901961, 0.7764706, 1.0)
            case .wardoDark: rgba = (0.1882353, 0.2156863, 0.1098039, 1.0)
            case .oceanLight: rgba = (0.9176471, 0.9529412, 1.0, 1.0)
            case .oceanDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            case .orchidLight: rgba = (0.9411765, 0.9372549, 1.0, 1.0)
            case .orchidDark: rgba = (0.1294118, 0.1058824, 0.2941176, 1.0)
            case .emberLight: rgba = (1.0, 0.9411765, 0.9372549, 1.0)
            case .emberDark: rgba = (0.2980392, 0.0862745, 0.0941176, 1.0)
            case .cloudLight: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            case .cloudDark: rgba = (0.2, 0.2, 0.2, 1.0)
            }
        case .actionSecondaryForeground:
            switch theme {
            case .wardoLight: rgba = (0.1254902, 0.145098, 0.0784314, 1.0)
            case .wardoDark: rgba = (0.9411765, 0.9490196, 0.8862745, 1.0)
            case .oceanLight: rgba = (0.0156863, 0.0784314, 0.1529412, 1.0)
            case .oceanDark: rgba = (0.9764706, 0.9882353, 1.0, 1.0)
            case .orchidLight: rgba = (0.0666667, 0.0470588, 0.1843137, 1.0)
            case .orchidDark: rgba = (0.9843137, 0.9803922, 1.0, 1.0)
            case .emberLight: rgba = (0.1960784, 0.0352941, 0.0431373, 1.0)
            case .emberDark: rgba = (1.0, 0.9803922, 0.9764706, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .stateDisabledBackground:
            switch theme {
            case .wardoLight: rgba = (0.1411765, 0.1411765, 0.1333333, 0.1215686)
            case .wardoDark: rgba = (1.0, 1.0, 1.0, 0.1215686)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.1215686)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.1215686)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.1215686)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.1215686)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.1215686)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.1215686)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.1215686)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.1215686)
            }
        case .stateDisabledForeground:
            switch theme {
            case .wardoLight: rgba = (0.1411765, 0.1411765, 0.1333333, 0.3803922)
            case .wardoDark: rgba = (1.0, 1.0, 1.0, 0.3803922)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.3803922)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.3803922)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.3803922)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.3803922)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.3803922)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.3803922)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.3803922)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.3803922)
            }
        case .feedbackSuccessBackground:
            switch theme {
            case .wardoLight: rgba = (0.8039216, 0.9372549, 0.8509804, 1.0)
            case .wardoDark: rgba = (0.0431373, 0.1960784, 0.1176471, 1.0)
            case .oceanLight: rgba = (0.8039216, 0.9372549, 0.8509804, 1.0)
            case .oceanDark: rgba = (0.0431373, 0.1960784, 0.1176471, 1.0)
            case .orchidLight: rgba = (0.8039216, 0.9372549, 0.8509804, 1.0)
            case .orchidDark: rgba = (0.0431373, 0.1960784, 0.1176471, 1.0)
            case .emberLight: rgba = (0.8039216, 0.9372549, 0.8509804, 1.0)
            case .emberDark: rgba = (0.0431373, 0.1960784, 0.1176471, 1.0)
            case .cloudLight: rgba = (0.8039216, 0.9372549, 0.8509804, 1.0)
            case .cloudDark: rgba = (0.0431373, 0.1960784, 0.1176471, 1.0)
            }
        case .feedbackSuccessForeground:
            switch theme {
            case .wardoLight: rgba = (0.0627451, 0.2784314, 0.1647059, 1.0)
            case .wardoDark: rgba = (0.8039216, 0.9372549, 0.8509804, 1.0)
            case .oceanLight: rgba = (0.0627451, 0.2784314, 0.1647059, 1.0)
            case .oceanDark: rgba = (0.9176471, 0.9764706, 0.9411765, 1.0)
            case .orchidLight: rgba = (0.0627451, 0.2784314, 0.1647059, 1.0)
            case .orchidDark: rgba = (0.9176471, 0.9764706, 0.9411765, 1.0)
            case .emberLight: rgba = (0.0627451, 0.2784314, 0.1647059, 1.0)
            case .emberDark: rgba = (0.9176471, 0.9764706, 0.9411765, 1.0)
            case .cloudLight: rgba = (0.0627451, 0.2784314, 0.1647059, 1.0)
            case .cloudDark: rgba = (0.9176471, 0.9764706, 0.9411765, 1.0)
            }
        case .feedbackErrorBackground:
            switch theme {
            case .wardoLight: rgba = (1.0, 0.8509804, 0.8392157, 1.0)
            case .wardoDark: rgba = (0.2980392, 0.0862745, 0.0941176, 1.0)
            case .oceanLight: rgba = (1.0, 0.8509804, 0.8392157, 1.0)
            case .oceanDark: rgba = (0.2980392, 0.0862745, 0.0941176, 1.0)
            case .orchidLight: rgba = (1.0, 0.8509804, 0.8392157, 1.0)
            case .orchidDark: rgba = (0.2980392, 0.0862745, 0.0941176, 1.0)
            case .emberLight: rgba = (1.0, 0.8509804, 0.8392157, 1.0)
            case .emberDark: rgba = (0.2980392, 0.0862745, 0.0941176, 1.0)
            case .cloudLight: rgba = (1.0, 0.8509804, 0.8392157, 1.0)
            case .cloudDark: rgba = (0.2980392, 0.0862745, 0.0941176, 1.0)
            }
        case .feedbackErrorForeground:
            switch theme {
            case .wardoLight: rgba = (0.4196078, 0.1254902, 0.1294118, 1.0)
            case .wardoDark: rgba = (1.0, 0.8509804, 0.8392157, 1.0)
            case .oceanLight: rgba = (0.4196078, 0.1254902, 0.1294118, 1.0)
            case .oceanDark: rgba = (1.0, 0.9411765, 0.9372549, 1.0)
            case .orchidLight: rgba = (0.4196078, 0.1254902, 0.1294118, 1.0)
            case .orchidDark: rgba = (1.0, 0.9411765, 0.9372549, 1.0)
            case .emberLight: rgba = (0.4196078, 0.1254902, 0.1294118, 1.0)
            case .emberDark: rgba = (1.0, 0.9411765, 0.9372549, 1.0)
            case .cloudLight: rgba = (0.4196078, 0.1254902, 0.1294118, 1.0)
            case .cloudDark: rgba = (1.0, 0.9411765, 0.9372549, 1.0)
            }
        case .feedbackWarningBackground:
            switch theme {
            case .wardoLight: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .wardoDark: rgba = (0.3490196, 0.1137255, 0.0117647, 1.0)
            case .oceanLight: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .oceanDark: rgba = (0.3490196, 0.1137255, 0.0117647, 1.0)
            case .orchidLight: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .orchidDark: rgba = (0.3490196, 0.1137255, 0.0117647, 1.0)
            case .emberLight: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .emberDark: rgba = (0.3490196, 0.1137255, 0.0117647, 1.0)
            case .cloudLight: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudDark: rgba = (0.3490196, 0.1137255, 0.0117647, 1.0)
            }
        case .feedbackWarningForeground:
            switch theme {
            case .wardoLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .wardoDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .oceanLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .oceanDark: rgba = (1.0, 0.9137255, 0.8470588, 1.0)
            case .orchidLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .orchidDark: rgba = (1.0, 0.9137255, 0.8470588, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.9137255, 0.8470588, 1.0)
            case .cloudLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .cloudDark: rgba = (1.0, 0.9137255, 0.8470588, 1.0)
            }
        case .feedbackInfoBackground:
            switch theme {
            case .wardoLight: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .wardoDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            case .oceanLight: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .oceanDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            case .orchidLight: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            case .emberLight: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .emberDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            case .cloudLight: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .cloudDark: rgba = (0.0470588, 0.145098, 0.2901961, 1.0)
            }
        case .feedbackInfoForeground:
            switch theme {
            case .wardoLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .wardoDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.9176471, 0.9529412, 1.0, 1.0)
            case .orchidLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.9176471, 0.9529412, 1.0, 1.0)
            case .emberLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .emberDark: rgba = (0.9176471, 0.9529412, 1.0, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .cloudDark: rgba = (0.9176471, 0.9529412, 1.0, 1.0)
            }
        case .overlayScrim:
            switch theme {
            case .wardoLight: rgba = (0.0, 0.0, 0.0, 0.4784314)
            case .wardoDark: rgba = (0.0, 0.0, 0.0, 0.6)
            case .oceanLight: rgba = (0.0, 0.0, 0.0, 0.6)
            case .oceanDark: rgba = (0.0, 0.0, 0.0, 0.6)
            case .orchidLight: rgba = (0.0, 0.0, 0.0, 0.6)
            case .orchidDark: rgba = (0.0, 0.0, 0.0, 0.6)
            case .emberLight: rgba = (0.0, 0.0, 0.0, 0.6)
            case .emberDark: rgba = (0.0, 0.0, 0.0, 0.6)
            case .cloudLight: rgba = (0.0, 0.0, 0.0, 0.6)
            case .cloudDark: rgba = (0.0, 0.0, 0.0, 0.6)
            }
        case .overlaySubtle:
            switch theme {
            case .wardoLight: rgba = (0.1411765, 0.1411765, 0.1333333, 0.0784314)
            case .wardoDark: rgba = (1.0, 1.0, 1.0, 0.0784314)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.0784314)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0784314)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.0784314)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0784314)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.0784314)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.0784314)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.0784314)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.0784314)
            }
        case .stateHover:
            switch theme {
            case .wardoLight: rgba = (0.1411765, 0.1411765, 0.1333333, 0.0509804)
            case .wardoDark: rgba = (1.0, 1.0, 1.0, 0.0509804)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.0509804)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0509804)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.0509804)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0509804)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.0509804)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.0509804)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.0509804)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.0509804)
            }
        case .statePressed:
            switch theme {
            case .wardoLight: rgba = (0.1411765, 0.1411765, 0.1333333, 0.1215686)
            case .wardoDark: rgba = (1.0, 1.0, 1.0, 0.1607843)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.1215686)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.1607843)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.1215686)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.1607843)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.1215686)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.1607843)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.1215686)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.1607843)
            }
        case .stateSelected:
            switch theme {
            case .wardoLight: rgba = (0.8509804, 0.9568627, 0.0, 0.1215686)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 0.2)
            case .oceanLight: rgba = (0.1254902, 0.3803922, 0.7372549, 0.1215686)
            case .oceanDark: rgba = (0.6705882, 0.8078431, 1.0, 0.2)
            case .orchidLight: rgba = (0.4823529, 0.2235294, 0.7098039, 0.1215686)
            case .orchidDark: rgba = (0.8823529, 0.6901961, 1.0, 0.2)
            case .emberLight: rgba = (0.7019608, 0.2666667, 0.0509804, 0.1215686)
            case .emberDark: rgba = (1.0, 0.6784314, 0.4235294, 0.2)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.1215686)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.2)
            }
        case .separatorDefault:
            switch theme {
            case .wardoLight: rgba = (0.6431373, 0.6235294, 0.6, 0.3411765)
            case .wardoDark: rgba = (0.9764706, 0.9490196, 0.9176471, 0.3411765)
            case .oceanLight: rgba = (0.2705882, 0.2980392, 0.3686275, 0.3411765)
            case .oceanDark: rgba = (0.8980392, 0.9137255, 0.9372549, 0.3411765)
            case .orchidLight: rgba = (0.2862745, 0.2901961, 0.3686275, 0.3411765)
            case .orchidDark: rgba = (0.9098039, 0.9058824, 0.9372549, 0.3411765)
            case .emberLight: rgba = (0.3372549, 0.2941176, 0.3333333, 0.3411765)
            case .emberDark: rgba = (0.9137255, 0.9058824, 0.9137255, 0.3411765)
            case .cloudLight: rgba = (0.2823529, 0.2823529, 0.2823529, 0.3411765)
            case .cloudDark: rgba = (0.9098039, 0.9098039, 0.9098039, 0.3411765)
            }
        case .backgroundSubtle:
            switch theme {
            case .wardoLight: rgba = (0.9372549, 0.9019608, 0.8666667, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.9607843, 0.9686275, 0.9764706, 1.0)
            case .oceanDark: rgba = (0.1372549, 0.1529412, 0.1921569, 1.0)
            case .orchidLight: rgba = (0.9647059, 0.9647059, 0.9764706, 1.0)
            case .orchidDark: rgba = (0.145098, 0.1490196, 0.1882353, 1.0)
            case .emberLight: rgba = (0.9686275, 0.9647059, 0.9686275, 1.0)
            case .emberDark: rgba = (0.1686275, 0.1490196, 0.172549, 1.0)
            case .cloudLight: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            case .cloudDark: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            }
        case .textOnBrand:
            switch theme {
            case .wardoLight: rgba = (0.145098, 0.1686275, 0.0078431, 1.0)
            case .wardoDark: rgba = (0.9529412, 0.945098, 0.7686275, 1.0)
            case .oceanLight: rgba = (0.0156863, 0.0784314, 0.1529412, 1.0)
            case .oceanDark: rgba = (0.9764706, 0.9882353, 1.0, 1.0)
            case .orchidLight: rgba = (0.1294118, 0.0352941, 0.1843137, 1.0)
            case .orchidDark: rgba = (0.9960784, 0.9764706, 1.0, 1.0)
            case .emberLight: rgba = (0.2039216, 0.0627451, 0.0, 1.0)
            case .emberDark: rgba = (1.0, 0.972549, 0.9490196, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .backgroundTertiary:
            switch theme {
            case .wardoLight: rgba = (0.9568627, 0.9019608, 0.7647059, 1.0)
            case .wardoDark: rgba = (0.2705882, 0.254902, 0.2156863, 1.0)
            case .oceanLight: rgba = (0.9098039, 0.972549, 0.9882353, 1.0)
            case .oceanDark: rgba = (0.0392157, 0.1921569, 0.2470588, 1.0)
            case .orchidLight: rgba = (0.9764706, 0.9019608, 0.7686275, 1.0)
            case .orchidDark: rgba = (0.2745098, 0.2, 0.0235294, 1.0)
            case .emberLight: rgba = (0.9843137, 0.9058824, 0.8823529, 1.0)
            case .emberDark: rgba = (0.2392157, 0.0980392, 0.0588235, 1.0)
            case .cloudLight: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            case .cloudDark: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            }
        case .textOnInverse:
            switch theme {
            case .wardoLight: rgba = (1.0, 0.9921569, 0.9882353, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .oceanDark: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .orchidLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidDark: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .emberLight: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .emberDark: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .cloudLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .cloudDark: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            }
        case .actionNeutral:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (1.0, 0.9921569, 0.9882353, 1.0)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .actionNeutralForeground:
            switch theme {
            case .wardoLight: rgba = (1.0, 0.9921569, 0.9882353, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .oceanDark: rgba = (0.0823529, 0.0941176, 0.1176471, 1.0)
            case .orchidLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidDark: rgba = (0.0901961, 0.0901961, 0.1215686, 1.0)
            case .emberLight: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .emberDark: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .cloudLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .cloudDark: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            }
        case .backgroundMessageReceived:
            switch theme {
            case .wardoLight: rgba = (0.8470588, 0.7803922, 0.7215686, 1.0)
            case .wardoDark: rgba = (0.3254902, 0.3058824, 0.2823529, 1.0)
            case .oceanLight: rgba = (0.8980392, 0.9137255, 0.9372549, 1.0)
            case .oceanDark: rgba = (0.1921569, 0.2156863, 0.2705882, 1.0)
            case .orchidLight: rgba = (0.9098039, 0.9058824, 0.9372549, 1.0)
            case .orchidDark: rgba = (0.2078431, 0.2078431, 0.2705882, 1.0)
            case .emberLight: rgba = (0.9137255, 0.9058824, 0.9137255, 1.0)
            case .emberDark: rgba = (0.2470588, 0.2117647, 0.2431373, 1.0)
            case .cloudLight: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            case .cloudDark: rgba = (0.2, 0.2, 0.2, 1.0)
            }
        case .iconBrand:
            switch theme {
            case .wardoLight: rgba = (0.4, 0.4509804, 0.0156863, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.2, 0.2, 0.2, 1.0)
            case .cloudDark: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            }
        case .textOnMedia:
            switch theme {
            case .wardoLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .wardoDark: rgba = (1.0, 1.0, 1.0, 1.0)
            case .oceanLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidLight: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .emberLight: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .cloudLight: rgba = (1.0, 1.0, 1.0, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .componentButtonForegroundSecondaryDefaultHover:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .componentButtonForegroundSecondaryDefaultPressed:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .componentButtonForegroundTextDefaultHover:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .componentButtonForegroundTextDefaultPressed:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .stateSelectedIndicator:
            switch theme {
            case .wardoLight: rgba = (0.2352941, 0.2666667, 0.0235294, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 1.0)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 1.0)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 1.0)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 1.0)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 1.0)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 1.0)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 1.0)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 1.0)
            }
        case .componentInputFocus:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.9058824, 0.9490196, 0.4078431, 0.3411765)
            case .oceanLight: rgba = (0.0705882, 0.2078431, 0.4078431, 0.3411765)
            case .oceanDark: rgba = (0.8196078, 0.8980392, 1.0, 0.3411765)
            case .orchidLight: rgba = (0.2705882, 0.1176471, 0.4078431, 0.3411765)
            case .orchidDark: rgba = (0.945098, 0.8352941, 1.0, 0.3411765)
            case .emberLight: rgba = (0.5215686, 0.1882353, 0.027451, 0.3411765)
            case .emberDark: rgba = (1.0, 0.8156863, 0.6509804, 0.3411765)
            case .cloudLight: rgba = (0.1411765, 0.1411765, 0.1411765, 0.3411765)
            case .cloudDark: rgba = (0.9686275, 0.9686275, 0.9686275, 0.3411765)
            }
        case .textVisionosOnSelected:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.0156863, 0.0784314, 0.1529412, 1.0)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .orchidLight: rgba = (0.1294118, 0.0352941, 0.1843137, 1.0)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 1.0)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 1.0)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 1.0)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 1.0)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 1.0)
            }
        case .cardShadowRaised:
            switch theme {
            case .wardoLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .wardoDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .oceanLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .oceanDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .orchidLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .orchidDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .emberLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .emberDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .cloudLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            case .cloudDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1215686)
            }
        case .cardShadowFloating:
            switch theme {
            case .wardoLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .wardoDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .oceanLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .oceanDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .orchidLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .orchidDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .emberLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .emberDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .cloudLight: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            case .cloudDark: rgba = (0.0313725, 0.0352941, 0.0313725, 0.1607843)
            }
        case .cardStateHover:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 0.0392157)
            case .wardoDark: rgba = (1.0, 0.9921569, 0.9882353, 0.0392157)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.0392157)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0392157)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.0392157)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0392157)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.0392157)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.0392157)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.0392157)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.0392157)
            }
        case .cardStatePressed:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 0.0784314)
            case .wardoDark: rgba = (1.0, 0.9921569, 0.9882353, 0.0784314)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.0784314)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0784314)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.0784314)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.0784314)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.0784314)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.0784314)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.0784314)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.0784314)
            }
        case .cardStateDragged:
            switch theme {
            case .wardoLight: rgba = (0.0862745, 0.0862745, 0.0823529, 0.1215686)
            case .wardoDark: rgba = (1.0, 0.9921569, 0.9882353, 0.1215686)
            case .oceanLight: rgba = (0.0823529, 0.0941176, 0.1176471, 0.1215686)
            case .oceanDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.1215686)
            case .orchidLight: rgba = (0.0901961, 0.0901961, 0.1215686, 0.1215686)
            case .orchidDark: rgba = (0.9882353, 0.9882353, 0.9921569, 0.1215686)
            case .emberLight: rgba = (0.1019608, 0.0901961, 0.1098039, 0.1215686)
            case .emberDark: rgba = (0.9882353, 0.9882353, 0.9882353, 0.1215686)
            case .cloudLight: rgba = (0.0705882, 0.0705882, 0.0705882, 0.1215686)
            case .cloudDark: rgba = (1.0, 1.0, 1.0, 0.1215686)
            }
        case .codeKeyword:
            switch theme {
            case .wardoLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .wardoDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .oceanLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .oceanDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .orchidLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .orchidDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .emberLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .emberDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .cloudLight: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .cloudDark: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            }
        case .codeString:
            switch theme {
            case .wardoLight: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .wardoDark: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .oceanLight: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .oceanDark: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .orchidLight: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .orchidDark: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .emberLight: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .emberDark: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .cloudLight: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .cloudDark: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            }
        case .codeNumber:
            switch theme {
            case .wardoLight: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .wardoDark: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .oceanLight: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .oceanDark: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .orchidLight: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .orchidDark: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .emberLight: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .emberDark: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .cloudLight: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .cloudDark: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            }
        case .codeFunction:
            switch theme {
            case .wardoLight: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .wardoDark: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .oceanLight: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .oceanDark: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .orchidLight: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .orchidDark: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .emberLight: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .emberDark: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .cloudLight: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .cloudDark: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            }
        case .codeInverseKeyword:
            switch theme {
            case .wardoLight: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .wardoDark: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .oceanLight: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .oceanDark: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .orchidLight: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .orchidDark: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .emberLight: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .emberDark: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            case .cloudLight: rgba = (0.6705882, 0.8078431, 1.0, 1.0)
            case .cloudDark: rgba = (0.0980392, 0.2901961, 0.5686275, 1.0)
            }
        case .codeInverseString:
            switch theme {
            case .wardoLight: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .wardoDark: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .oceanLight: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .oceanDark: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .orchidLight: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .orchidDark: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .emberLight: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .emberDark: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            case .cloudLight: rgba = (0.6431373, 0.8705882, 0.7254902, 1.0)
            case .cloudDark: rgba = (0.0901961, 0.3803922, 0.2235294, 1.0)
            }
        case .codeInverseNumber:
            switch theme {
            case .wardoLight: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .wardoDark: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .oceanLight: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .oceanDark: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .orchidLight: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .orchidDark: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .emberLight: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .emberDark: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            case .cloudLight: rgba = (1.0, 0.7176471, 0.6901961, 1.0)
            case .cloudDark: rgba = (0.5764706, 0.172549, 0.1803922, 1.0)
            }
        case .codeInverseFunction:
            switch theme {
            case .wardoLight: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .wardoDark: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .oceanLight: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .oceanDark: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .orchidLight: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .orchidDark: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .emberLight: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .emberDark: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            case .cloudLight: rgba = (0.8823529, 0.6901961, 1.0, 1.0)
            case .cloudDark: rgba = (0.3764706, 0.1686275, 0.5529412, 1.0)
            }
        case .skeletonSurface:
            switch theme {
            case .wardoLight: rgba = (0.9019608, 0.8509804, 0.8, 1.0)
            case .wardoDark: rgba = (0.1686275, 0.1607843, 0.1490196, 1.0)
            case .oceanLight: rgba = (0.8980392, 0.9137255, 0.9372549, 1.0)
            case .oceanDark: rgba = (0.1372549, 0.1529412, 0.1921569, 1.0)
            case .orchidLight: rgba = (0.9098039, 0.9058824, 0.9372549, 1.0)
            case .orchidDark: rgba = (0.145098, 0.1490196, 0.1882353, 1.0)
            case .emberLight: rgba = (0.9137255, 0.9058824, 0.9137255, 1.0)
            case .emberDark: rgba = (0.1686275, 0.1490196, 0.172549, 1.0)
            case .cloudLight: rgba = (0.9098039, 0.9098039, 0.9098039, 1.0)
            case .cloudDark: rgba = (0.1411765, 0.1411765, 0.1411765, 1.0)
            }
        case .cardFilledSurface:
            switch theme {
            case .wardoLight: rgba = (0.8980392, 0.8745098, 0.854902, 1.0)
            case .wardoDark: rgba = (0.1764706, 0.1764706, 0.172549, 1.0)
            case .oceanLight: rgba = (0.8862745, 0.8941176, 0.9019608, 1.0)
            case .oceanDark: rgba = (0.172549, 0.1843137, 0.2039216, 1.0)
            case .orchidLight: rgba = (0.8901961, 0.8901961, 0.9019608, 1.0)
            case .orchidDark: rgba = (0.1803922, 0.1803922, 0.2078431, 1.0)
            case .emberLight: rgba = (0.8941176, 0.8901961, 0.8941176, 1.0)
            case .emberDark: rgba = (0.1921569, 0.1803922, 0.1960784, 1.0)
            case .cloudLight: rgba = (0.8941176, 0.8941176, 0.8941176, 1.0)
            case .cloudDark: rgba = (0.1647059, 0.1647059, 0.1647059, 1.0)
            }
        case .cardFilledBorder:
            switch theme {
            case .wardoLight: rgba = (0.7058824, 0.6901961, 0.6705882, 1.0)
            case .wardoDark: rgba = (0.3137255, 0.3137255, 0.3098039, 1.0)
            case .oceanLight: rgba = (0.6980392, 0.7058824, 0.7176471, 1.0)
            case .oceanDark: rgba = (0.3098039, 0.3176471, 0.3372549, 1.0)
            case .orchidLight: rgba = (0.7019608, 0.7019608, 0.7215686, 1.0)
            case .orchidDark: rgba = (0.3137255, 0.3137255, 0.3411765, 1.0)
            case .emberLight: rgba = (0.7098039, 0.7019608, 0.7098039, 1.0)
            case .emberDark: rgba = (0.3254902, 0.3137255, 0.3294118, 1.0)
            case .cloudLight: rgba = (0.6980392, 0.6980392, 0.6980392, 1.0)
            case .cloudDark: rgba = (0.3019608, 0.3019608, 0.3019608, 1.0)
            }
        }
        return Color(.sRGB, red: rgba.0, green: rgba.1, blue: rgba.2, opacity: rgba.3)
    }
}
