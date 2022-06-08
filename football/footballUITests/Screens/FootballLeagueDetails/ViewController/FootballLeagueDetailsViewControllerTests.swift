//
//  FootballLeagueDetailsViewControllerTests.swift
//  footballUITests
//
//  Created by Itesh Dutt on 23/05/22.
//

import XCTest

class FootballLeagueDetailsViewControllerTests: XCTestCase {
    let app = XCUIApplication()
    let displayNameIdentifier = "displayNameIdentifier"
    let displayDateIdentifier = "displayDateIdentifier"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testNavigation() {
        app.tables.staticTexts[displayNameIdentifier].firstMatch.tap()
        app.navigationBars.buttons["Premier League"].tap()
        app.tables.staticTexts[displayDateIdentifier].firstMatch.tap()
        app.navigationBars.buttons["Premier League"].tap()
    }
    
    func testElementExists() {
        let nameLabel = app.tables.staticTexts[displayNameIdentifier].firstMatch.label
        XCTAssertFalse(nameLabel.isEmpty)
        let dateLabel = app.tables.staticTexts[displayDateIdentifier].firstMatch.label
        XCTAssertFalse(dateLabel.isEmpty)
    }
}
