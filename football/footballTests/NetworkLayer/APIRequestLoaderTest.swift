//
//  APIRequestLoaderTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 06/06/22.
//

import XCTest
@testable import football

class APIRequestLoaderTests: BaseXCTestCase {
    
    var loader: APIRequestLoader<FootballLeagueDetailsRequest>!
    
    override func setUp() {
        let request = FootballLeagueDetailsRequest()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }

    func testApiLoaderSuccess()  {
        let mockedData = loadJson(filename: "FootballLeagueDetailsResponseMock")
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.path.contains("/leagues/eng.1/seasons"), true)
            return (HTTPURLResponse(), mockedData, nil)
        }
        let expectation = XCTestExpectation(description: "response")
        loader.loadApiRequest(requestData: FootballLeagueDetailsEndpoint.getLeagueDetails) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                XCTAssertFalse(response.data?.seasons?.isEmpty ?? true)
                expectation.fulfill()
            case .failure(_):
                XCTFail("APi should return Mocked data")
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testApiLoaderParseError()  {
        let mockedData = loadJson(filename: "FootballLeagueDetailsResponseMockFail")
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.path.contains("/leagues/eng.1/seasons"), true)
            return (HTTPURLResponse(), mockedData, nil)
        }
        let expectation = XCTestExpectation(description: "response")
        loader.loadApiRequest(requestData: FootballLeagueDetailsEndpoint.getLeagueDetails) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                XCTAssertTrue(response.data?.seasons?.isEmpty ?? true)
                expectation.fulfill()
            case .failure(_):
                XCTFail("APi should return Mocked data")
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
