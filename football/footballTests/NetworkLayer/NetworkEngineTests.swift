//
//  NetworkEngineTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 28/05/22.
//

import XCTest

@testable import football

class NetworkEngineTests: XCTestCase {
    
    func testSuccessApiRequest() {
        let expectation = self.expectation(description: "Network call success")
        let endPoint = FootballLeagueDetailsEndpoint.getLeagueDetails
        NetworkEngine.request(endpoint: endPoint) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            print("Called testSuccessApiRequest")

            switch result{
            case  .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Fail")
            }
        }
        self.waitForExpectations(timeout: 5)
    }
    
    func testFailApiRequest() {
        let expectation = self.expectation(description: "Network call should fail")
        let endPoint = FailEndPoint.failApiCallEndpoint
        NetworkEngine.request(endpoint: endPoint) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            print("Called testFailApiRequest")
            switch result{
            case  .success(_):
                XCTFail("Api should Fail")
            case .failure(_):
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5)
    }
    
    func testUnableToParseResponse() {
        let expectation = self.expectation(description: "Network call should fail")
        let endPoint = FootballLeagueDetailsEndpoint.getLeagueDetails
        NetworkEngine.request(endpoint: endPoint) { (result: Result<InvalidResponse, ClientError>) in
            print("Called testUnableToparseResponse")

            switch result{
            case  .success(_):
                XCTFail("Api should Fail")
            case .failure(_):
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5)
    }
}


enum FailEndPoint: EndPoint {
    case failApiCallEndpoint
    case invalidUrlEndPoint
    
    var scheme: String {
        return NetworkConstants.schemeName
    }
    
    var baseURL: String {
        switch self {
        case .failApiCallEndpoint:
            return NetworkConstants.baseUrl
        case .invalidUrlEndPoint:
            return ""
        }
    }
    
    var path: String{
        switch self {
        case .failApiCallEndpoint:
            return "invalidPath"
        case .invalidUrlEndPoint:
            return ""
        }
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return NetworkConstants.getMethod
    }
}

struct InvalidResponse: Codable {
    let status: Bool?
    let data: String?
}
