//
//  FootbalLeagueDetailsViewModel.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation
import SwiftLoader

fileprivate class Constants {
    static let loadingText = "Loading..."
}

/// This class will have business logic for season details screen
class FootballLeagueDetailsViewModel {

    private let navigationHandler: FootballLeagueDetailsNavigationHandler
    private let dataProvider: IFootballLeagueDetailsDataProvider
    var seasons = [LeagueSeasonsCellViewModel]()

    init(viewController: UIViewController, dataProvider:IFootballLeagueDetailsDataProvider ) {
        navigationHandler = FootballLeagueDetailsNavigationHandler(controller: viewController as! FootballLeagueDetailsViewController)
        self.dataProvider = dataProvider
    }
    
    /// This will make api call to network engine for getting premier league details for every year
    /// - Parameter year: an instance of string
    /// - Returns: array of LeagueSeasonsCellViewModel
    func getLeagueDetailsData() async throws -> [LeagueSeasonsCellViewModel]? {
        let seasons: [LeagueSeasonsCellViewModel]? = try await withCheckedThrowingContinuation({ continuation in
            dataProvider.getLeagueDetails { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: data)
                }
            }
        })
        return seasons
    }
    
    /// This will call navigation handler for navigation to Season Details screen
    /// - Parameter year: year
    func navigateToDetailsScreen(year: Int) {
        navigationHandler.routeToDetailsScreen(year: year)
    }
}
