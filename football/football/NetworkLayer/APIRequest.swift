//
//  APIRequest.swift
//  football
//
//  Created by Itesh Dutt on 06/06/22.
//

import Foundation

protocol APIRequest {
    associatedtype ResponseDataType
    func makeRequest(from endpoint: EndPoint) throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}
