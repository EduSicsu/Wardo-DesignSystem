import Foundation
import CoreGraphics
import ImageIO

/// Samples the actual Figma spectrum rather than approximating its color geometry.
@MainActor public enum WardoSpectrumSampler {
    private struct Pixels {
        let width: Int
        let height: Int
        let bytes: [UInt8]
    }
    private static let pixels: Pixels? = {
        guard let url = Bundle.module.url(forResource: "spectrum", withExtension: "png", subdirectory: "Images") ?? Bundle.module.url(forResource: "spectrum", withExtension: "png"),
              let source = CGImageSourceCreateWithURL(url as CFURL, nil),
              let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
              let space = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
        let width = image.width, height = image.height
        var bytes = [UInt8](repeating: 0, count: width * height * 4)
        let rendered = bytes.withUnsafeMutableBytes { buffer -> Bool in
            guard let context = CGContext(data: buffer.baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: space, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return false }
            context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            return true
        }
        return rendered ? Pixels(width: width, height: height, bytes: bytes) : nil
    }()
    public static func color(at point: CGPoint, opacity: Double = 1) -> WardoRGBA? {
        guard let pixels, point.x.isFinite, point.y.isFinite else { return nil }
        let x = Int(min(1, max(0, point.x)) * Double(pixels.width - 1))
        let y = Int(min(1, max(0, point.y)) * Double(pixels.height - 1))
        let index = (y * pixels.width + x) * 4
        let alpha = Double(pixels.bytes[index + 3]) / 255
        guard alpha > 0 else { return nil }
        return WardoRGBA(red: Double(pixels.bytes[index]) / 255 / alpha, green: Double(pixels.bytes[index + 1]) / 255 / alpha, blue: Double(pixels.bytes[index + 2]) / 255 / alpha, opacity: opacity)
    }
    public static func nearestPoint(to color: WardoRGBA) -> CGPoint {
        guard let pixels else { return CGPoint(x: 0.5, y: 0) }
        var closest = Double.infinity
        var point = CGPoint(x: 0.5, y: 0)
        for y in stride(from: 0, to: pixels.height, by: 2) {
            for x in stride(from: 0, to: pixels.width, by: 2) {
                let index = (y * pixels.width + x) * 4
                let alpha = Double(pixels.bytes[index + 3]) / 255
                guard alpha > 0 else { continue }
                let r = Double(pixels.bytes[index]) / 255 / alpha - color.red
                let g = Double(pixels.bytes[index + 1]) / 255 / alpha - color.green
                let b = Double(pixels.bytes[index + 2]) / 255 / alpha - color.blue
                let distance = r * r + g * g + b * b
                if distance < closest { closest = distance; point = CGPoint(x: Double(x) / Double(pixels.width - 1), y: Double(y) / Double(pixels.height - 1)) }
            }
        }
        return point
    }
}
