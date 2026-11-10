import Testing
@testable import WardoDesignSystem

@Test func pagingKeepsSelectionVisibleAndCannotCrossEndpoints() {
    for count in [1, 2, 5, 8, 9, 100] {
        for selection in [-100, 0, count / 2, count - 1, 1_000] {
            let window = WardoPageWindow(count: count, selection: selection)
            #expect(window.pages.contains(window.selection))
            #expect(window.pages.count <= 8)
            #expect(window.pages.lowerBound >= 0 && window.pages.upperBound <= count)
            #expect((0..<count).contains(window.advanced(by: -1)))
            #expect((0..<count).contains(window.advanced(by: 1)))
        }
    }
    #expect(WardoPageWindow(count: 5, selection: 0).advanced(by: -1) == 0)
    #expect(WardoPageWindow(count: 5, selection: 4).advanced(by: 1) == 4)
}

@Test func compactPagingMapsVisiblePositionsAndRejectsInvalidGeometry() {
    let window = WardoPageWindow(count: 5, selection: 2)
    // 5 dots (4 × 8 + 16), 4 gaps (12): 96 points, centered in 120.
    #expect(window.page(at: 16, width: 120) == 0)
    #expect(window.page(at: 60, width: 120) == 2)
    #expect(window.page(at: 104, width: 120) == 4)
    #expect(window.page(at: .nan, width: 120) == 2)
    #expect(window.page(at: 60, width: 0) == 2)
    let many = WardoPageWindow(count: 100, selection: 50)
    #expect(many.diameter(for: many.pages.lowerBound) == 4)
    #expect(many.diameter(for: many.pages.upperBound - 1) == 4)
    #expect(many.diameter(for: 50) == 8)
}
