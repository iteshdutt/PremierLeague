//
//  SeasonDetailsRequestTest.swift
//  footballTests
//
//  Created by Itesh Dutt on 07/06/22.
//

import XCTest
@testable import football

class SeasonDetailsRequestTest: BaseXCTestCase {
    let request = SeasonDetailsRequest()
    
    func testMakeRequest() {
        do {
            let urlRequest = try request.makeRequest(from: SeasonDetailsEndPoints.getSeasonDetails(year: "2020"))
            XCTAssertTrue(urlRequest.url?.scheme == NetworkConstants.schemeName)
            XCTAssertTrue(urlRequest.url?.path == "/leagues/eng.1/standings")
            XCTAssertTrue(urlRequest.url?.host == NetworkConstants.baseUrl)
        } catch  {
            XCTFail("URL is not valid")
        }
    }
    
    func testBadRequest() {
        do {
            let badEndpoint  = MockBadEndpoint.enpoint
            let _ = try request.makeRequest(from: badEndpoint)
            XCTFail("URL should not be valid")
        } catch  {
            XCTAssertNotNil(error)
        }
    }
    
    func testParseResponse() {
        if let data = loadJson(filename: "SeasonStandingsMock") {
            do {
                let responseData = try request.parseResponse(data: data)
                print("Response data \(responseData)")
                XCTAssertFalse(responseData.data?.standings?.isEmpty ?? true)
            } catch  {
                XCTFail("Response data is not valid")
            }
        } else {
            XCTFail("Unable to load Mock data")
        }
    }
    
    func testParseFailResponse() {
        if let data = loadJson(filename: "SeasonStandingsMockFail") {
            do {
                let responseData = try request.parseResponse(data: data)
                XCTAssertNil(responseData.data)
            } catch  {
                XCTFail("Response should be nil")
            }
        } else {
            XCTFail("Unable to load Mock data")
        }
    }
}
