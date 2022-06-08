//
//  FootballLeagueDetailsDataProviderTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 29/05/22.
//

import XCTest
@testable import football

class FootballLeagueDetailsDataProviderTests: BaseXCTestCase {

    let dataProvider = FootballLeagueDetailsDataProvider()
    
    func testGetLeagueDetails() {
        let request = FootballLeagueDetailsRequest()
        var mockResponse: FootballLeagueDetailsReponse?
        let mockSession = MockNetworkSession()
        let jsonData = loadJson(filename: "FootballLeagueDetailsResponseMock")
        mockSession.data = jsonData
        let apiLoader = APIRequestLoader(apiRequest: request, urlSession: mockSession)
        let expectation = self.expectation(description: "Proper response come")
        apiLoader.loadApiRequest(requestData: FootballLeagueDetailsEndpoint.getLeagueDetails) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                mockResponse = response
                expectation.fulfill()
            case .failure(_):
                XCTFail("APi should return Mocked data")
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertFalse(mockResponse?.data?.seasons?.isEmpty ?? true)
    }
}
