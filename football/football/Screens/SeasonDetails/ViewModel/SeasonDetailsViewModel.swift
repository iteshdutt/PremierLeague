//
//  SeasonDetailsViewModel.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

/// This class will have business logic for season details screen
class SeasonDetailsViewModel {
    
    private let dataProvider: ISeasonDetailsDataProvider
    var standings = [StandingsCellViewModel]()
    var year: String!
    
    init(dataProvider: ISeasonDetailsDataProvider) {
        self.dataProvider = dataProvider
    }
    
    /// This will make api call to network engine for getting season details for selected season
    /// - Parameter year: an instance of string
    /// - Returns: array of StandingsCellViewModel
    func getSeasonDetails() async throws -> [StandingsCellViewModel]? {
        let standings: [StandingsCellViewModel]? = try await withCheckedThrowingContinuation({ continuation in
            dataProvider.getSelectedSeasonDetails(year: self.year) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: data)
                }
            }
        })
        return standings
    }
}
