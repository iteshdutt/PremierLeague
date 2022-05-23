//
//  SeasonDetailsReponse.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

struct SeasonDetailsReponse: Codable {
    let status: Bool?
    let data: SeasonReponseData?
}

struct SeasonReponseData: Codable {
    let name: String?
    let abbreviation: String?
    let seasonDisplay: String?
    let season: Int?
    let standings: [SeasonStandings]?
}

struct SeasonStandings: Codable {
    let team: TeamDetails?
    let note: Notes?
    let stats: [Stats]?
}

struct TeamDetails: Codable {
    let id: String?
    let uid: String?
    let name: String?
    let location: String?
    let abbreviation: String?
    let displayName: String?
    let shortDisplayName: String?
    let isActive: Bool?
    let logos: [Logos]?
}

struct Notes: Codable {
    let color: String?
    let description: String?
    let rank: Int?
}

struct Logos: Codable {
    let href: String?
    let alt: String?
    let width: Int?
    let height: Int?
    let lastUpdated: String?
}

struct Stats: Codable {
    let name: String?
    let displayName: String?
    let shortDisplayName: String?
    let description: String?
    let abbreviation: String?
    let type: String?
    let value: Int?
    let displayValue: String?
}
