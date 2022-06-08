//
//  MockURLProtocol.swift
//  footballTests
//
//  Created by Itesh Dutt on 06/06/22.
//

import Foundation
import XCTest
@testable import football

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?, Error?))?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        returnMockResponse()
    }
    
    override func stopLoading() {
        returnMockResponse()
    }
    
    fileprivate func returnMockResponse() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data, error) = try handler(request)
            if let response = response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            }
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            }
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}



class MockNetworkSession: NetworkingSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}
