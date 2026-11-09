// Generated from tokens/controls.figma.json by npm run tokens.
import CoreGraphics

public enum WardoSharedControlSize: String, CaseIterable, Sendable {
    case m = "M"
    case xs = "XS"
    case s = "S"
    case l = "L"
    case xl = "XL"
    case xxl = "2XL"
    case chonky = "Chonky"
    case hero = "Hero"
}

public struct WardoSharedControlMetrics: Sendable {
    public let minHeight: CGFloat
    public let contentSpacing: CGFloat
    public let labelFontSize: CGFloat
    public let labelLineHeight: CGFloat
    public init(size: WardoSharedControlSize = .m) {
        switch size {
        case .m: self.minHeight = 48; self.contentSpacing = 8; self.labelFontSize = 16; self.labelLineHeight = 19.200000762939453
        case .xs: self.minHeight = 32; self.contentSpacing = 4; self.labelFontSize = 12; self.labelLineHeight = 14.399999618530273
        case .s: self.minHeight = 40; self.contentSpacing = 4; self.labelFontSize = 14; self.labelLineHeight = 16.799999237060547
        case .l: self.minHeight = 64; self.contentSpacing = 8; self.labelFontSize = 20; self.labelLineHeight = 24
        case .xl: self.minHeight = 72; self.contentSpacing = 12; self.labelFontSize = 24; self.labelLineHeight = 28.799999237060547
        case .xxl: self.minHeight = 88; self.contentSpacing = 12; self.labelFontSize = 32; self.labelLineHeight = 38.400001525878906
        case .chonky: self.minHeight = 100; self.contentSpacing = 16; self.labelFontSize = 36; self.labelLineHeight = 43.20000076293945
        case .hero: self.minHeight = 116; self.contentSpacing = 16; self.labelFontSize = 40; self.labelLineHeight = 48
        }
    }
}

public enum WardoSharedControlContent: Sendable {
    case labelled, icon
    public var horizontalPadding: CGFloat { switch self { case .labelled: 24; case .icon: 0 } }
    public var verticalPadding: CGFloat { switch self { case .labelled: 12; case .icon: 0 } }
}

public enum WardoSharedControlCondition: String, CaseIterable, Sendable {
    case normal = "Normal", serious = "Serious", chonky = "Chonky"
    public var cornerRadius: CGFloat {
        switch self {
        case .normal: 8
        case .serious: 4
        case .chonky: 256
        }
    }
}
