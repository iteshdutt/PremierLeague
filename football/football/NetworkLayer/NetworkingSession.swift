//
//  NetworkingSession.swift
//  football
//
//  Created by Itesh Dutt on 07/06/22.
//

import Foundation

protocol NetworkingSession {
    func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkingSession {
    func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request) { data, response, error in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}
