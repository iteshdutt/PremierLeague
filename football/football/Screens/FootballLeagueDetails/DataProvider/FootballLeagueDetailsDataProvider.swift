//
//  FootbalLeagueDetailsDataProvider.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

protocol IFootballLeagueDetailsDataProvider {
    func getLeagueDetails(completion: @escaping (FootballLeagueDetailsReponseData?, ClientError?) -> ())
}

/// This class will make use of IFootballLeagueDetailsDataProvider protocol for getting premier league details
class FootballLeagueDetailsDataProvider: IFootballLeagueDetailsDataProvider {
    
    /// This function will make call to network engine for getting data for premier league
    /// - Parameters:
    ///   - completion: completion handler for FootballLeagueDetailsReponseData and error
    func getLeagueDetails(completion: @escaping (FootballLeagueDetailsReponseData?, ClientError?) -> ()) {
        let endPoint = FootballLeagueDetailsEndpoint.getLeagueDetails
        NetworkEngine.request(endpoint: endPoint) { (result: Result<FootballLeagueDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
