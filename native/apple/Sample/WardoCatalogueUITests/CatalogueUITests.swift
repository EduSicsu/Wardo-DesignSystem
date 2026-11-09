import XCTest

@MainActor final class CatalogueUITests: XCTestCase {
    func testActionsSearchAndPresentation() throws {
        let app = XCUIApplication(); app.launch()
        XCTAssertTrue(app.navigationBars["Wardo native catalogue"].waitForExistence(timeout: 20))
        app.buttons["Activate"].tap()
        XCTAssertTrue(app.staticTexts["Button activated"].exists)
        let search = app.textFields["Find events"]
        XCTAssertTrue(search.exists)
        search.tap(); search.typeText(" and books\n")
        reveal(app.buttons["Show alert"], in: app)
        app.buttons["Show alert"].tap()
        XCTAssertTrue(app.alerts["Wardo alert"].waitForExistence(timeout: 5))
        app.alerts.buttons["Continue"].tap()
        XCTAssertTrue(app.staticTexts["Alert confirmed"].waitForExistence(timeout: 5))
        #if !os(visionOS)
        let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); screenshot.name = "Native catalogue"; screenshot.lifetime = .keepAlways; add(screenshot)
        #endif
    }
    func testCustomControlsExposeNativeToggleSemantics() throws {
        let app = XCUIApplication(); app.launch()
        let toggle = app.switches["Vision notifications"]
        reveal(toggle, in: app)
        XCTAssertTrue(toggle.exists)
        let before = toggle.value as? String
        toggle.tap()
        XCTAssertNotEqual(toggle.value as? String, before)
        let checkbox = app.switches["Select reminders"]
        reveal(checkbox, in: app)
        let selected = checkbox.value as? String
        checkbox.tap()
        XCTAssertNotEqual(checkbox.value as? String, selected)
    }
    func testColorPickerCanSelectTabSaveAndClose() throws {
        let app = XCUIApplication(); app.launch()
        let choose = app.buttons["Choose color"]
        reveal(choose, in: app)
        choose.tap()
        XCTAssertTrue(app.buttons["Close color picker"].waitForExistence(timeout: 5))
        app.segmentedControls.buttons["Sliders"].tap()
        XCTAssertTrue(app.textFields["RGB Hex Color"].exists)
        app.segmentedControls.buttons["Spectrum"].tap()
        XCTAssertTrue(app.sliders["Hue"].exists)
        app.segmentedControls.buttons["Grid"].tap()
        app.buttons["Color #000000"].firstMatch.tap()
        #if !os(visionOS)
        let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); screenshot.name = "Wardo color grid"; screenshot.lifetime = .keepAlways; add(screenshot)
        #endif
        app.buttons["Close color picker"].tap()
        XCTAssertTrue(choose.waitForExistence(timeout: 5))
    }
    func testSidebarSelectionAndRTL() throws {
        let app = XCUIApplication(); app.launch()
        let link = app.buttons["Sidebar example"]
        reveal(link, in: app); link.tap()
        let saved = app.buttons["sidebar-saved"]
        XCTAssertTrue(saved.waitForExistence(timeout: 5)); saved.tap()
        XCTAssertTrue(saved.isSelected)
        XCTAssertTrue(app.staticTexts["Selected: Saved"].exists)
        app.buttons["Hide Library"].tap()
        XCTAssertFalse(saved.exists)
        app.buttons["Show Library"].tap()
        XCTAssertTrue(saved.exists)
        let direction = app.switches["Right-to-left layout"]
        flip(direction)
        app.buttons["sidebar-inbox"].tap()
        XCTAssertTrue(app.buttons["sidebar-inbox"].isSelected)
        XCTAssertTrue(app.staticTexts["Selected: Inbox"].exists)
    }
    func testPagingUsesApplicationStateAndSupportsRTL() throws {
        let app = XCUIApplication(); app.launch()
        let link = app.buttons["Paging example"]
        reveal(link, in: app); link.tap()
        let paging = app.descendants(matching: .any)["Document pages"].firstMatch
        XCTAssertTrue(paging.waitForExistence(timeout: 5))
        #if os(visionOS)
        paging.tap()
        XCTAssertTrue(app.staticTexts["Selected page: 3 of 5"].waitForExistence(timeout: 5))
        app.buttons["Previous page"].tap(); app.buttons["Previous page"].tap()
        #endif
        app.buttons["Next page"].tap()
        XCTAssertTrue(app.staticTexts["Selected page: 2 of 5"].exists)
        flip(app.switches["Right-to-left paging"])
        app.buttons["Next page"].tap()
        XCTAssertTrue(app.staticTexts["Selected page: 3 of 5"].exists)
        app.buttons["Use two pages"].tap()
        XCTAssertTrue(app.staticTexts["Selected page: 2 of 2"].exists)
        XCTAssertFalse(app.buttons["Next page"].isEnabled)
        app.buttons["Previous page"].tap()
        XCTAssertTrue(app.staticTexts["Selected page: 1 of 2"].exists)
        XCTAssertFalse(app.buttons["Previous page"].isEnabled)
        flip(app.switches["Right-to-left paging"])
        #if !os(visionOS)
        paging.coordinate(withNormalizedOffset: CGVector(dx: 0.85, dy: 0.5)).tap()
        XCTAssertTrue(app.staticTexts["Selected page: 2 of 2"].waitForExistence(timeout: 5))
        #endif
        #if !os(visionOS)
        let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); screenshot.name = "Wardo native paging"; screenshot.lifetime = .keepAlways; add(screenshot)
        #endif
    }
    func testSliderSizesStopsDisabledStateAndRTL() throws {
        let app = XCUIApplication(); app.launch()
        let link = app.buttons["Slider variants"]
        reveal(link, in: app); link.tap()
        let slider = app.sliders["Stepped volume"]
        XCTAssertTrue(slider.waitForExistence(timeout: 5))
        for size in ["Large", "Regular", "Small", "Mini"] {
            let sizeButton = app.segmentedControls.buttons[size]
            sizeButton.tap()
            XCTAssertTrue(sizeButton.isSelected)
            XCTAssertGreaterThanOrEqual(slider.frame.height, 44)
            #if os(visionOS)
            app.buttons["Reset stepped value"].tap()
            XCTAssertTrue(app.staticTexts["Stepped value: 0%"].exists)
            slider.tap()
            XCTAssertTrue(app.staticTexts["Stepped value: 50%"].exists)
            #else
            setSlider(slider, to: 1)
            XCTAssertTrue(app.staticTexts["Stepped value: 100%"].exists)
            setSlider(slider, to: 0)
            XCTAssertTrue(app.staticTexts["Stepped value: 0%"].exists)
            #endif
        }
        flip(app.switches["Right-to-left sliders"])
        #if os(visionOS)
        app.buttons["Reset stepped value"].tap()
        slider.tap()
        XCTAssertTrue(app.staticTexts["Stepped value: 50%"].exists)
        #else
        slider.coordinate(withNormalizedOffset: CGVector(dx: 0.05, dy: 0.5)).tap()
        XCTAssertTrue(app.staticTexts["Stepped value: 100%"].exists)
        #endif
        XCTAssertTrue(app.staticTexts["Slider idle"].exists)
        flip(app.switches["Enable sliders"])
        XCTAssertFalse(slider.isEnabled)
    }
    func testSectionIndexScrubbingNavigatesAndRespectsRTLAndDisabledState() throws {
        let app = XCUIApplication(); app.launch()
        let link = app.buttons["Section index example"]
        reveal(link, in: app); link.tap()
        let index = app.sliders["section-index"]
        XCTAssertTrue(index.waitForExistence(timeout: 5))
        XCTAssertGreaterThanOrEqual(index.frame.width, 44)
        #if os(visionOS)
        index.tap()
        XCTAssertTrue(app.staticTexts["Selected section: N"].waitForExistence(timeout: 5))
        app.buttons["Go to last section"].tap()
        XCTAssertEqual(index.value as? String, "#")
        #else
        index.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.98)).tap()
        #endif
        XCTAssertTrue(app.staticTexts["Selected section: #"].exists)
        XCTAssertTrue(app.staticTexts["Section #"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Section #"].isHittable)
        let originalX = index.frame.minX
        flip(app.switches["Right-to-left section index"])
        XCTAssertLessThan(index.frame.minX, originalX)
        #if os(visionOS)
        index.tap()
        XCTAssertTrue(app.staticTexts["Selected section: N"].exists)
        #else
        index.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.02)).tap()
        XCTAssertTrue(app.staticTexts["Selected section: A"].exists)
        #endif
        flip(app.switches["Enable section index"])
        XCTAssertFalse(index.isEnabled)
    }
    func testAppleDestinationItemsExposeSelectionBadgesRTLAndLargeText() throws {
        let app = XCUIApplication(); app.launch()
        let link = app.buttons["Apple navigation item example"]
        reveal(link, in: app); link.tap()
        let sidebar = app.buttons["Sidebar destination"]
        let tab = app.buttons["Tab destination"]
        let text = app.buttons["Text destination"]
        XCTAssertTrue(sidebar.waitForExistence(timeout: 5))
        XCTAssertGreaterThanOrEqual(sidebar.frame.height, 44)
        XCTAssertGreaterThanOrEqual(tab.frame.height, 54)
        XCTAssertGreaterThanOrEqual(text.frame.height, 44)
        XCTAssertEqual(sidebar.value as? String, "3 unread items")
        #if os(visionOS)
        sidebar.tap()
        #else
        sidebar.coordinate(withNormalizedOffset: CGVector(dx: 0.95, dy: 0.5)).tap()
        #endif
        XCTAssertTrue(sidebar.isSelected)
        XCTAssertTrue(app.staticTexts["Selected destination: Sidebar"].exists)
        tab.tap()
        XCTAssertTrue(tab.isSelected)
        XCTAssertFalse(sidebar.isSelected)
        text.tap()
        XCTAssertTrue(text.isSelected)
        XCTAssertTrue(app.staticTexts["Selected destination: Text"].exists)
        let originalX = sidebar.frame.minX
        flip(app.switches["Right-to-left destination items"])
        XCTAssertGreaterThan(sidebar.frame.minX, originalX)
        sidebar.tap()
        XCTAssertTrue(sidebar.isSelected)
        #if !os(visionOS)
        let normal = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); normal.name = "Wardo destination items selected and RTL"; normal.lifetime = .keepAlways; add(normal)
        #endif
        let originalHeight = sidebar.frame.height
        flip(app.switches["Large navigation text"])
        XCTAssertGreaterThan(sidebar.frame.height, originalHeight)
        XCTAssertGreaterThan(sidebar.frame.width, 240)
        XCTAssertEqual(sidebar.frame.width, text.frame.width, accuracy: 1)
        flip(app.switches["Enable destination items"])
        XCTAssertFalse(sidebar.isEnabled)
        XCTAssertFalse(tab.isEnabled)
        XCTAssertFalse(text.isEnabled)
        text.tap()
        XCTAssertTrue(app.staticTexts["Selected destination: Sidebar"].exists)
        #if !os(visionOS)
        let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); screenshot.name = "Wardo destination items with large text"; screenshot.lifetime = .keepAlways; add(screenshot)
        #endif
    }
    /// A native switch's label can span its row while the knob remains trailing.
    /// Validate state so a label-only tap cannot masquerade as an RTL/disabled check.
    private func flip(_ toggle: XCUIElement) {
        let before = toggle.value as? String
        let widget = toggle.descendants(matching: .other).firstMatch
        if widget.exists && widget.frame.width <= 100 {
            widget.tap()
        } else {
            toggle.coordinate(withNormalizedOffset: CGVector(dx: 1, dy: 0.5)).withOffset(CGVector(dx: -min(32, toggle.frame.width / 2), dy: 0)).tap()
        }
        XCTAssertNotEqual(toggle.value as? String, before, "The sample switch must change state")
    }
    private func setSlider(_ slider: XCUIElement, to value: CGFloat) {
        slider.coordinate(withNormalizedOffset: CGVector(dx: value == 0 ? 0.05 : 0.95, dy: 0.5)).tap()
    }
    private func reveal(_ element: XCUIElement, in app: XCUIApplication) {
        for _ in 0..<8 {
            if element.exists && element.isHittable { return }
            let surface: XCUIElement
            if app.collectionViews.firstMatch.exists { surface = app.collectionViews.firstMatch }
            else if app.scrollViews.firstMatch.exists { surface = app.scrollViews.firstMatch }
            else { surface = app }
            #if os(visionOS)
            surface.swipeUp()
            #else
            // Centered swipes can land on the catalogue's slider thumbs.
            let start = surface.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.8))
            let end = surface.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.2))
            start.press(forDuration: 0.05, thenDragTo: end)
            #endif
        }
        let hierarchy = XCTAttachment(string: app.debugDescription); hierarchy.name = "Unreachable catalogue control"; hierarchy.lifetime = .keepAlways; add(hierarchy)
        XCTAssertTrue(element.exists && element.isHittable, "The control must be reachable by scrolling")
    }

}
