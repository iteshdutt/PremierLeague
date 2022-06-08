//
//  FootballLeagueDetailsRequest.swift
//  football
//
//  Created by Itesh Dutt on 06/06/22.
//

import Foundation

struct FootballLeagueDetailsRequest: APIRequest {
    /// This function will return an instance of URLRequest based on endpoint
    /// - Parameter endpoint: an instance of EndPoint
    /// - Returns: URLRequest
    func makeRequest(from endpoint: EndPoint) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        guard let url = components.url else {
            throw ClientError.invalidUrl
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        return urlRequest
    }
    
    /// This function will parse the api response to data model object
    /// - Parameter data: an instance of Data
    /// - Returns: an instance of FootballLeagueDetailsReponse
    func parseResponse(data: Data) throws -> FootballLeagueDetailsReponse {
        return try JSONDecoder().decode(FootballLeagueDetailsReponse.self, from: data)
    }
}
