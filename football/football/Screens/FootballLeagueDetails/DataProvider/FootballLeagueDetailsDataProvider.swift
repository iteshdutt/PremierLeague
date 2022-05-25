//
//  FootbalLeagueDetailsDataProvider.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

protocol IFootballLeagueDetailsDataProvider {
    func getLeagueDetails(completion: @escaping ([LeagueSeasonsCellViewModel]?, ClientError?) -> ())
}

/// This class will make use of IFootballLeagueDetailsDataProvider protocol for getting premier league details
class FootballLeagueDetailsDataProvider: IFootballLeagueDetailsDataProvider {
    
    /// This function will make call to network engine for getting data for premier league
    /// - Parameters:
    ///   - completion: completion handler for LeagueSeasonsCellViewModel and error
    func getLeagueDetails(completion: @escaping ([LeagueSeasonsCellViewModel]?, ClientError?) -> ()) {
        let endPoint = FootballLeagueDetailsEndpoint.getLeagueDetails
        NetworkEngine.request(endpoint: endPoint) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                let responseData = response.data?.seasons
                let seasonCellViewModels = responseData?.map { leagueSeason -> LeagueSeasonsCellViewModel in
                    let leagueSeasonDate = DateUtility().getLeagueSeasonDate(season: leagueSeason)
                    let year = leagueSeason.year!
                    return LeagueSeasonsCellViewModel(displayName: leagueSeason.displayName!, leagueSeasonDate: leagueSeasonDate, year: year)
                }
                completion(seasonCellViewModels, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
