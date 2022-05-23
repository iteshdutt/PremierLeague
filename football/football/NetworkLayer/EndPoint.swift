//
//  EndPoint.swift
//  football
//
//  Created by Itesh Dutt on 21/05/22.
//

import Foundation

/// This class will get all required parameters for making an api call
protocol EndPoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
