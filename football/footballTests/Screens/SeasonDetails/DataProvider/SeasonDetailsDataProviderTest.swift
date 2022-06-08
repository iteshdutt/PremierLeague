//
//  SeasonDetailsDataProviderTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 29/05/22.
//

import XCTest
@testable import football

class SeasonDetailsDataProviderTests: BaseXCTestCase {
    let dataProvider = SeasonDetailsDataProvider()
    
    func testGetLeagueDetails() {
        let request = SeasonDetailsRequest()
        var mockResponse: SeasonDetailsReponse?
        let mockSession = MockNetworkSession()
        let jsonData = loadJson(filename: "SeasonStandingsMock")
        mockSession.data = jsonData
        let apiLoader = APIRequestLoader(apiRequest: request, urlSession: mockSession)
        let expectation = self.expectation(description: "Proper response come")
        apiLoader.loadApiRequest(requestData: SeasonDetailsEndPoints.getSeasonDetails(year: "2020")) { (result: Result<SeasonDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                mockResponse = response
                expectation.fulfill()
            case .failure(_):
                XCTFail("APi should return Mocked data")
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertFalse(mockResponse?.data?.standings?.isEmpty ?? true)
    }
}
