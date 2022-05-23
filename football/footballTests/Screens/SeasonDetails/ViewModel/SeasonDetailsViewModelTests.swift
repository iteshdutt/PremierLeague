//
//  SeasonDetailsViewModelTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 23/05/22.
//

import XCTest
@testable import football

class SeasonDetailsViewModelTests: XCTestCase {
    
    let seasonDetailsViewModel: SeasonDetailsViewModel = SeasonDetailsViewModel()
    
    func testGetDisplayName() {
        let emptyStatistics = Stats(name: nil, displayName: nil, shortDisplayName: nil, description: nil, abbreviation: nil, type: nil, value: nil, displayValue: nil)

        let emptyDisplayName = seasonDetailsViewModel.getDisplayName(statistics: emptyStatistics)
        XCTAssertEqual(emptyDisplayName, "")

        let validStatistics = Stats(name: "name", displayName: "Wins", shortDisplayName: "W", description: "Team's current Win-Loss record", abbreviation: "W", type: "wins", value: 27, displayValue: "27")
        let validDisplayName = seasonDetailsViewModel.getDisplayName(statistics: validStatistics)
        XCTAssertEqual(validDisplayName, "Wins - 27")
    }
}
