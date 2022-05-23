//
//  SeasonDetailsCoordinator.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

/// This class is intermediate class for view controller to make api calls and handling business logic
class SeasonDetailsCoordinator {
    private let dataProvider: ISeasonDetailsDataProvider
    private let viewModel: SeasonDetailsViewModel
    
    init() {
        dataProvider = SeasonDetailsDataProvider()
        viewModel = SeasonDetailsViewModel()
    }
    
    /// This will make api call to network engine for getting season details for selected season
    /// - Parameter year: an instance of string
    /// - Returns: array of SingleSeasonAttributes
    func getSeasonDetails(year: String) async throws -> [SingleSeasonAttributes] {
        let standings: [SeasonStandings] = try await withCheckedThrowingContinuation({ continuation in
            dataProvider.getSelectedSeasonDetails(year: year) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    let leagueStandings = data?.standings ?? [SeasonStandings]()
                    continuation.resume(returning: leagueStandings)
                }
            }
        })
        let leagueStandings = standings.map { teamDetails -> SingleSeasonAttributes in
            var imageUrl = GlobalConstants.dummyImageUrl
            let logos = teamDetails.team?.logos;
            if(!(logos?.isEmpty ?? true)) {
                imageUrl = logos![0].href!;
            }
            let statistics = teamDetails.stats
            let teamStats = statistics?.map({ statistics -> StatsAttributes in
                let displayName = viewModel.getDisplayName(statistics: statistics)
                return StatsAttributes(displayName: displayName)
            })
            let teamStatistics = teamStats ?? [StatsAttributes]()
            return SingleSeasonAttributes(displayName: teamDetails.team?.displayName ?? "", imageUrl: imageUrl, stats:teamStatistics)
        }
        return leagueStandings
    }
}
