//
//  ClientError.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

enum ClientError: Error {
    case noInternetConnection
    case invalidUrl
    case invalidResponse
    case failToParseResponse
    case apiError(Error)
}
