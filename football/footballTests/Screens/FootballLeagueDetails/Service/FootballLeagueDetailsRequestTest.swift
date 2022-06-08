//
//  FootballLeagueDetailsRequestTest.swift
//  footballTests
//
//  Created by Itesh Dutt on 06/06/22.
//

import XCTest
@testable import football

class FootballLeagueDetailsRequestTest: BaseXCTestCase {
    let request = FootballLeagueDetailsRequest()
    func testMakeRequest() {
        do {
            let urlRequest = try request.makeRequest(from: FootballLeagueDetailsEndpoint.getLeagueDetails)
            XCTAssertTrue(urlRequest.url?.scheme == NetworkConstants.schemeName)
            XCTAssertTrue(urlRequest.url?.path == "/leagues/eng.1/seasons")
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
        if let data = loadJson(filename: "FootballLeagueDetailsResponseMock") {
            do {
                let responseData = try request.parseResponse(data: data)
                print("Response data \(responseData)")
                XCTAssertFalse(responseData.data?.seasons?.isEmpty ?? true)
            } catch  {
                XCTFail("Response data is not valid")
            }
        } else {
            XCTFail("Unable to load Mock data")
        }
    }
    
    func testParseFailResponse() {
        if let data = loadJson(filename: "FootballLeagueDetailsResponseMockFail") {
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
