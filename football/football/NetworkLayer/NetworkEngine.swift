//
//  NetworkEngine.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

/// This class is responsible for handling network requests
class NetworkEngine {
    
    /// This function will make api request call
    /// - Parameters:
    ///   - endpoint: an instance of EndPoint for getting required parameters
    ///   - completion: completion block for success and error scenarios
    class func request<T: Codable>(endpoint: EndPoint, completion: @escaping (Result<T, ClientError>) -> ()){
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.apiError(error!)))
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    completion(.failure(.failToParseResponse))
                }
            }
        }
        dataTask.resume()
    }
}
