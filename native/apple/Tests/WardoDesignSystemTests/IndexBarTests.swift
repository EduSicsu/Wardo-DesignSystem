import Testing
@testable import WardoDesignSystem

@Test func sectionScrubbingClampsAtBothEndsAndIncludesTheFinalSymbol() {
    #expect(WardoIndexPosition.index(at: -40, height: 466, count: 27) == 0)
    #expect(WardoIndexPosition.index(at: 233, height: 466, count: 27) == 13)
    #expect(WardoIndexPosition.index(at: 466, height: 466, count: 27) == 26)
    #expect(WardoIndexPosition.index(at: 900, height: 466, count: 27) == 26)
}

@Test func sectionScrubbingRejectsEmptyAndInvalidGeometry() {
    #expect(WardoIndexPosition.index(at: 0, height: 466, count: 0) == nil)
    #expect(WardoIndexPosition.index(at: .nan, height: 466, count: 27) == nil)
    #expect(WardoIndexPosition.index(at: 2, height: .infinity, count: 27) == nil)
    #expect(WardoIndexPosition.index(at: 0, height: 0, count: 27) == nil)
    #expect(WardoIndexPosition.index(at: 100, height: 466, count: 1) == 0)
}
