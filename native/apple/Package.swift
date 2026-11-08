// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "WardoDesignSystem",
    platforms: [.iOS("26.0"), .visionOS("26.0"), .macOS("26.0")],
    products: [.library(name: "WardoDesignSystem", targets: ["WardoDesignSystem"])],
    targets: [.target(name: "WardoDesignSystem", resources: [.process("Resources")])]
)
