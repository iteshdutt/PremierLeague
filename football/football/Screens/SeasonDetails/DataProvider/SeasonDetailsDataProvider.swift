//
//  SeasonDetailsDataProvider.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

protocol ISeasonDetailsDataProvider {
    func getSelectedSeasonDetails(year: String, completion: @escaping (SeasonReponseData?, ClientError?) -> ())
}

/// This class will make use of ISeasonDetailsDataProvider protocol for getting season details
class SeasonDetailsDataProvider: ISeasonDetailsDataProvider {
    
    /// This function will make call to network engine for getting data for selected season
    /// - Parameters:
    ///   - year: an instance of string
    ///   - completion: completion handler for SeasonReponseData and error
    func getSelectedSeasonDetails(year: String, completion: @escaping (SeasonReponseData?, ClientError?) -> ()) {
        let endPoint = SeasonDetailsEndPoints.getSeasonDetails(year: year)
        NetworkEngine.request(endpoint: endPoint) { (result: Result<SeasonDetailsReponse, ClientError>) in
            switch result{
            case  .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
