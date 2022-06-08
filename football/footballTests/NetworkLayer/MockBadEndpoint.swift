//
//  MockBadEndpoint.swift
//  footballTests
//
//  Created by Itesh Dutt on 07/06/22.
//

import Foundation
@testable import football

enum MockBadEndpoint: EndPoint {
    case enpoint
    
    var scheme: String {
        return NetworkConstants.schemeName
    }
    
    var baseURL: String {
        return NetworkConstants.baseUrl
    }
    
    var path: String{
        return "@"
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return NetworkConstants.getMethod
    }
}
