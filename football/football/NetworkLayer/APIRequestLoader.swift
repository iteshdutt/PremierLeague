//
//  APIRequestLoader.swift
//  football
//
//  Created by Itesh Dutt on 07/06/22.
//

import Foundation

class APIRequestLoader<T: APIRequest> {
    let apiRequest: T
    let urlSession: NetworkingSession
    
    init(apiRequest: T, urlSession: NetworkingSession = URLSession.shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    /// This function will make API call using Networking Session
    /// - Parameters:
    ///   - requestData: an instance of Endpoint for creating URLRequest
    ///   - completion: completion handler of Result type
    func loadApiRequest(requestData: EndPoint, completion: @escaping (Result<T.ResponseDataType, ClientError>) -> Void) {
        do {
            let urlRequest = try apiRequest.makeRequest(from: requestData)
            urlSession.loadData(with: urlRequest){ data, response, error in
                guard  let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let parseResponse = try self.apiRequest.parseResponse(data: data)
                    completion(.success(parseResponse))
                } catch {
                    completion(.failure(.failToParseResponse))
                }
            }
        } catch {
            completion(.failure(.invalidUrl))
        }
    }
}
