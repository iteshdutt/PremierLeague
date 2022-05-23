//
//  FootbalLeagueDetailsViewModel.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

fileprivate class Constants {
    public static let dateFormat = "yyyy-MM-dd'T'hh:mmZ"
    public static let dateDisplayFormat = "dd/MMM/yyyy"
}

/// This class will have business logic for season details screen
class FootballLeagueDetailsViewModel {
    
    /// This function will parse and return string for start date and end date of a season
    /// - Parameter season: an instance of FootballLeagueDetailsSeason
    /// - Returns: an instance of String
    func getLeagueSeasonDate(season: FootballLeagueDetailsSeason) -> String {
        guard let startDate = season.startDate, let endDate = season.endDate else {
            return ""
        }
        
        let startDisplayDate = parseDate(dateString: startDate)
        let endDisplayDate = parseDate(dateString: endDate)
        if !startDisplayDate.isEmpty {
            return "\(startDisplayDate) - \(endDisplayDate)"
        } else {
            return endDisplayDate
        }
    }
    
    /// This function will parse date using DateFormatter and return user readable date in selected format
    /// - Parameter dateString: dateString
    /// - Returns: an instance of String
    private func parseDate(dateString: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = Constants.dateFormat
        if let date = dateformat.date(from: dateString) {
            dateformat.dateFormat = Constants.dateDisplayFormat
            return dateformat.string(from: date)
        }
        return ""
    }
}
