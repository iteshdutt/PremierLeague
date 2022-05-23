//
//  FootbalLeagueDetailsCoordinator.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation
import UIKit

/// This class is intermediate class for view controller to make api calls and handling business logic
class FootballLeagueDetailsCoordinator {
    
    private let navigationHandler: FootballLeagueDetailsNavigationHandler
    private let dataProvider: IFootballLeagueDetailsDataProvider
    private let viewModel: FootballLeagueDetailsViewModel
    
    init(viewController: UIViewController) {
        navigationHandler = FootballLeagueDetailsNavigationHandler(controller: viewController as! FootballLeagueDetailsViewController)
        dataProvider = FootballLeagueDetailsDataProvider()
        viewModel = FootballLeagueDetailsViewModel()
    }
    
    /// This will make api call to network engine for getting premier league details for every year
    /// - Parameter year: an instance of string
    /// - Returns: array of PremierLeagueSeasonAttributes
    func getLeagueDetailsData() async throws -> [PremierLeagueSeasonAttributes] {
        let seasons: [FootballLeagueDetailsSeason] = try await withCheckedThrowingContinuation({ continuation in
            dataProvider.getLeagueDetails { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: data?.seasons ?? [FootballLeagueDetailsSeason]())
                }
            }
        })
        let premierLeagueSeasons = seasons.map { leagueSeason -> PremierLeagueSeasonAttributes in
            let leagueSeasonDate = viewModel.getLeagueSeasonDate(season: leagueSeason)
            let year = leagueSeason.year!
            return PremierLeagueSeasonAttributes(displayName: leagueSeason.displayName!, leagueSeasonDate: leagueSeasonDate, year: year)
        }
        return premierLeagueSeasons
    }
    
    /// This will call coordinator for navigation to Season Details screen
    /// - Parameter year: year
    func navigateToDetailsScreen(year: Int) {
        navigationHandler.routeToDetailsScreen(year: year)
    }
}
