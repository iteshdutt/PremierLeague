//
//  FootballLeagueDetailsViewModelTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 23/05/22.
//

import XCTest

@testable import football

class FootballLeagueDetailsViewModelTests: XCTestCase {
    
    let viewModel: FootballLeagueDetailsViewModel = FootballLeagueDetailsViewModel()
    
    func testGetDisplayName() {
        let emptySeason = FootballLeagueDetailsSeason(year: nil, startDate: nil, endDate: nil, displayName: nil, types: nil)
        let emptyDisplayName = viewModel.getLeagueSeasonDate(season: emptySeason)
        XCTAssertEqual(emptyDisplayName, "")

        let validSeason = FootballLeagueDetailsSeason(year: 2021, startDate: "2021-06-01T04:00Z", endDate: "2022-06-01T03:59Z", displayName: "2021-22 English Premier League", types: nil)
        let validDisplayName = viewModel.getLeagueSeasonDate(season: validSeason)
        XCTAssertEqual(validDisplayName, "01/Jun/2021 - 01/Jun/2022")
    }
}
