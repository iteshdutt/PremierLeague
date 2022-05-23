//
//  FootballLeagueDetailsViewControllerTests.swift
//  footballUITests
//
//  Created by Itesh Dutt on 23/05/22.
//

import XCTest

class FootballLeagueDetailsViewControllerTests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testNavigation() {
      let leaguePredicate = NSPredicate(format: "label beginswith '2021-22'")
      app.tables.staticTexts.element(matching: leaguePredicate).tap()
      app.navigationBars.buttons["Premier League"].tap()
    }
    
    func testElementExists() {
        XCTAssert(app.tables.staticTexts["2007-08 Barclays Premier League"].exists, "String does not exist")
        XCTAssert(app.tables.staticTexts["2001-02 Barclays Premier League"].exists, "String does not exist")
        XCTAssert(app.tables.staticTexts["2010-11 Barclays Premier League"].exists, "String does not exist")
        XCTAssert(app.tables.staticTexts["2015-16 Barclays Premier League"].exists, "String does not exist")
        XCTAssert(!app.tables.staticTexts["XXXXX"].exists, "String does exist")
        XCTAssert(app.tables.staticTexts["01/Jun/2021 - 01/Jun/2022"].exists, "String does not exist")
    }
}
