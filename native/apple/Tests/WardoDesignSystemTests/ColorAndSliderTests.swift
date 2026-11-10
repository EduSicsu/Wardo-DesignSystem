import Testing
@testable import WardoDesignSystem
import SwiftUI

@Test func colorRoundTripsAndPreservesAlpha() throws {
    let color = try #require(WardoRGBA(hex: "#FF550580"))
    #expect(color.hex == "FF5505")
    #expect(abs(color.opacity - 128.0 / 255) < 0.0001)
    #expect(WardoRGBA(hex: "not-a-color") == nil)
    #expect(WardoRGBA(hex: "12345") == nil)
}
@Test func boundedColorValues() {
    let color = WardoRGBA(red: -1, green: 2, blue: .nan, opacity: .infinity)
    #expect(color.hex == "00FF00")
    #expect(color.opacity == 0)
}
@Test func paletteMatchesDesignGrid() {
    #expect(WardoColorPalette.grid.count == 120)
    #expect(WardoColorPalette.grid.first?.hex == "FEFFFE")
    #expect(WardoColorPalette.grid[11].hex == "000000")
    #expect(WardoColorPalette.grid[65].hex == "FF4015")
}
@Test func sliderSnapsRelativeToLowerBoundWithoutCrossingEndpoints() {
    typealias Slider = WardoVisionSlider<EmptyView>
    #expect(Slider.quantized(5.3, in: 5...10, step: 0.5) == 5.5)
    #expect(Slider.quantized(-1, in: 5...10, step: 0.5) == 5)
    #expect(Slider.quantized(11, in: 5...10, step: 0.5) == 10)
    #expect(Slider.quantized(.nan, in: 5...10, step: 0.5) == 5)
    #expect(Slider.quantized(0.3, in: 0...1, step: 0.25) == 0.25)
    #expect(Slider.quantized(0.4, in: 0...1, step: 0.25) == 0.5)
}
@Test func spectrumHasContinuousHueEndpoints() {
    #expect(WardoRGBA.spectrum(hue: 0, saturation: 1).hex == "FF0000")
    #expect(WardoRGBA.spectrum(hue: 1, saturation: 1).hex == "FF0000")
    #expect(WardoRGBA.spectrum(hue: 0.5, saturation: 0).hex == "FFFFFF")
}
@Test func everySemanticColorResolvesInEveryTheme() {
    #expect(WardoColorToken.allCases.count == 69)
    #expect(WardoTheme.allCases.count == 10)
    for theme in WardoTheme.allCases { for token in WardoColorToken.allCases { _ = token.color(in: theme) } }
}

@Test func calendarRespectsFirstWeekdayAndLeapYear() throws {
    var calendar = Calendar(identifier: .gregorian); calendar.timeZone = try #require(TimeZone(secondsFromGMT: 0)); calendar.firstWeekday = 2
    let date = try #require(calendar.date(from: DateComponents(year: 2024, month: 2, day: 15)))
    let cells = WardoCalendarGrid.dates(in: date, calendar: calendar)
    #expect(cells.count % 7 == 0)
    #expect(cells.prefix(3).allSatisfy { $0 == nil })
    #expect(cells.compactMap { $0 }.count == 29)
    #expect(calendar.component(.day, from: try #require(cells.compactMap { $0 }.last)) == 29)
}

@MainActor @Test func spectrumSamplesTheExactArtworkAndRespectsOrientation() throws {
    let upper = try #require(WardoSpectrumSampler.color(at: CGPoint(x: 0.5, y: 0.25)))
    let lower = try #require(WardoSpectrumSampler.color(at: CGPoint(x: 0.5, y: 0.75)))
    #expect(upper.green > upper.blue)
    #expect(lower.blue > lower.green)
    let point = WardoSpectrumSampler.nearestPoint(to: upper)
    let sampled = try #require(WardoSpectrumSampler.color(at: point))
    #expect(abs(sampled.green - upper.green) < 0.1)
}

@Test func colorRemainsBoundedAfterApplicationOwnedMutations() {
    var color = WardoRGBA(red: 0.5, green: 0.5, blue: 0.5)
    color.red = 2; color.green = -Double.infinity; color.blue = Double.nan; color.opacity = -0.5
    #expect(color.hex == "FF0000")
    #expect(color.opacity == 0)
    let invalidSpectrum = WardoRGBA.spectrum(hue: Double.nan, saturation: Double.infinity, brightness: Double.infinity)
    #expect(invalidSpectrum.hex == "000000")
    #expect(invalidSpectrum.red.isFinite && invalidSpectrum.green.isFinite && invalidSpectrum.blue.isFinite)
}
