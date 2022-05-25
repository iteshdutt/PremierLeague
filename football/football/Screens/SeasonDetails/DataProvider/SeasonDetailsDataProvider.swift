//
//  SeasonDetailsDataProvider.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

protocol ISeasonDetailsDataProvider {
    func getSelectedSeasonDetails(year: String, completion: @escaping ([StandingsCellViewModel]?, ClientError?) -> ())
}

/// This class will make use of ISeasonDetailsDataProvider protocol for getting season details
class SeasonDetailsDataProvider: ISeasonDetailsDataProvider {
    
    /// This function will make call to network engine for getting data for selected season
    /// - Parameters:
    ///   - year: an instance of string
    ///   - completion: completion handler for StandingsCellViewModel and error
    func getSelectedSeasonDetails(year: String, completion: @escaping ([StandingsCellViewModel]?, ClientError?) -> ()) {
        let endPoint = SeasonDetailsEndPoints.getSeasonDetails(year: year)
        NetworkEngine.request(endpoint: endPoint) { [self] (result: Result<SeasonDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                let responseData = response.data?.standings
                let leagueStandings = responseData?.map { teamDetails -> StandingsCellViewModel in
                    var imageUrl = GlobalConstants.dummyImageUrl
                    let logos = teamDetails.team?.logos;
                    if(!(logos?.isEmpty ?? true)) {
                        imageUrl = logos![0].href!;
                    }
                    let statistics = teamDetails.stats
                    let teamStats = statistics?.map({ statistics -> StatsAttributes in
                        let displayName = getDisplayName(statistics: statistics)
                        return StatsAttributes(displayName: displayName)
                    })
                    let teamStatistics = teamStats ?? [StatsAttributes]()
                    return StandingsCellViewModel(displayName: teamDetails.team?.displayName ?? "", imageUrl: imageUrl, stats:teamStatistics)
                }
                completion(leagueStandings, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    /// This function will parse and return string for display name which includes display name and display value
    /// - Parameter statistics: an instance of Stats
    /// - Returns: an instance of String
    private func getDisplayName(statistics: Stats) -> String {
        guard let displayName = statistics.displayName, let displayValue = statistics.displayValue else {
            return ""
        }
        return "\(displayName) - \(displayValue)"
    }
}
