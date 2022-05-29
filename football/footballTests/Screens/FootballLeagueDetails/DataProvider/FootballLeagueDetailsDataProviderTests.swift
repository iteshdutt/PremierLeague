//
//  FootballLeagueDetailsDataProviderTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 29/05/22.
//

import XCTest
@testable import football

class FootballLeagueDetailsDataProviderTests: XCTestCase {

    let dataProvider = FootballLeagueDetailsDataProvider()
    
    func testGetLeagueDetails() {
        let expectation = self.expectation(description: "Network call should not fail")
        dataProvider.getLeagueDetails(completion: { data, error in
            if(error != nil){
                XCTFail("Api should not Fail")
                return
            }
            if(!(data?.isEmpty ?? true)) {
                expectation.fulfill()
            }
        })
        self.waitForExpectations(timeout: 5)
    }    
}
