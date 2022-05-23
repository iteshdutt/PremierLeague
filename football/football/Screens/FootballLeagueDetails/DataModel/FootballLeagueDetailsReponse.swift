//
//  FootballLeagueDetailsReponse.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

struct FootballLeagueDetailsReponse: Codable {
    let status: Bool?
    let data: FootballLeagueDetailsReponseData?
}

struct FootballLeagueDetailsReponseData: Codable {
    let desc: String?
    let seasons: [FootballLeagueDetailsSeason]?
}

struct FootballLeagueDetailsSeason: Codable {
    let year: Int?
    let startDate: String?
    let endDate: String?
    let displayName: String?
    let types: [SeasonTypes?]?
}

struct SeasonTypes: Codable {
    let id: String?
    let name: String?
    let abbreviation: String?
    let startDate: String?
    let endDate: String?
    let hasStanding: Bool?
}
