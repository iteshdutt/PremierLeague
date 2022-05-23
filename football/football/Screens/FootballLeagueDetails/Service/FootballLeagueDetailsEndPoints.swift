//
//  FootballLeagueDetailsEndPoints.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

fileprivate class Constants {
    public static let path = "/leagues/eng.1/seasons"
}

/// This class will get all required parameters for making an api call
enum FootballLeagueDetailsEndpoint: EndPoint {
    case getLeagueDetails
    
    var scheme: String {
        switch self {
        case .getLeagueDetails:
            return GlobalConstants.schemeName
        }
    }
    
    var baseURL: String {
        switch self {
        case .getLeagueDetails:
            return GlobalConstants.baseUrl
        }
    }
    
    var path: String{
        switch self {
        case .getLeagueDetails:
            return Constants.path
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLeagueDetails:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getLeagueDetails:
            return GlobalConstants.getMethod
        }
    }
}
