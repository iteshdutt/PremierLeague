//
//  DateUtilityTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 29/05/22.
//

import XCTest

@testable import football

class DateUtilityTests: XCTestCase {
    
    func testGetDisplayName() {
        let emptySeason = FootballLeagueDetailsSeason(year: nil, startDate: nil, endDate: nil, displayName: nil, types: nil)
        let emptyDisplayName = DateUtility().getLeagueSeasonDate(season: emptySeason)
        XCTAssertEqual(emptyDisplayName, "")
        
        let validStartEndDateSeason = FootballLeagueDetailsSeason(year: 2021, startDate: "2021-06-01T04:00Z", endDate: "2022-06-01T03:59Z", displayName: "2021-22 English Premier League", types: nil)
        let validDisplayName = DateUtility().getLeagueSeasonDate(season: validStartEndDateSeason)
        XCTAssertEqual(validDisplayName, "01/Jun/2021 - 01/Jun/2022")
        
        let validEndDateSeason = FootballLeagueDetailsSeason(year: 2021, startDate: "", endDate: "2022-06-01T03:59Z", displayName: "2021-22 English Premier League", types: nil)
        let endDateDisplayName = DateUtility().getLeagueSeasonDate(season: validEndDateSeason)
        XCTAssertEqual(endDateDisplayName, "01/Jun/2022")

    }
}
