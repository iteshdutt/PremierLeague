//
//  FootballLeagueDetailsEndPoints.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

fileprivate class Constants {
    public static let path = "/leagues/eng.1/standings"
    public static let seasonKey = "season"
    public static let sortKey = "sort"
    public static let ascValue = "asc"
}

/// This class will get all required parameters for making an api call
enum SeasonDetailsEndPoints: EndPoint {
    case getSeasonDetails(year: String)
    
    var scheme: String {
        switch self {
        case .getSeasonDetails(_):
            return NetworkConstants.schemeName
        }
    }
    
    var baseURL: String {
        switch self {
        case .getSeasonDetails(_):
            return NetworkConstants.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .getSeasonDetails(_):
            return Constants.path
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getSeasonDetails(let year):
            return [
                URLQueryItem(name: Constants.seasonKey, value: year),
                URLQueryItem(name: Constants.sortKey, value: Constants.ascValue)
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getSeasonDetails(_):
            return NetworkConstants.getMethod
        }
    }
}
