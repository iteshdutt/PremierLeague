//
//  SeasonDetailsDataProviderTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 29/05/22.
//

import XCTest
@testable import football

class SeasonDetailsDataProviderTests: XCTestCase {
    let dataProvider = SeasonDetailsDataProvider()
    
    func testGetSelectedSeasonDetails() {
        let expectation = self.expectation(description: "Network call should not fail")
        dataProvider.getSelectedSeasonDetails(year: "2020") { data, error in
            if(error != nil){
                XCTFail("Api should not Fail")
                return
            }
            if(!(data?.isEmpty ?? true)) {
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5)
    }
    
    func testErrorGetSelectedSeasonDetails() {
        let expectation = self.expectation(description: "Network call should not fail")
        dataProvider.getSelectedSeasonDetails(year: "1900") { data, error in
            
            if(error != nil){
                expectation.fulfill()
            }
            if(!(data?.isEmpty ?? true)) {
                XCTFail("Api should Fail")
            }
        }
        self.waitForExpectations(timeout: 5)
    }
    
}
