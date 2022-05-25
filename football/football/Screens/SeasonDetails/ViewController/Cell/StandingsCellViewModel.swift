//
//  StandingsCellViewModel.swift
//  football
//
//  Created by Itesh Dutt on 28/05/22.
//

import Foundation

struct StandingsCellViewModel {
    var displayName: String
    var imageUrl: String
    let stats: [StatsAttributes]
}

struct StatsAttributes {
    var displayName: String
}
