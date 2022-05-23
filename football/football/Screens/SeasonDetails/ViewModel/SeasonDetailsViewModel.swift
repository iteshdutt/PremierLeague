//
//  SeasonDetailsViewModel.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation

/// This class will have business logic for season details screen
class SeasonDetailsViewModel {
    
    /// This function will parse and return string for display name which includes display name and display value
    /// - Parameter statistics: an instance of Stats
    /// - Returns: an instance of String
    func getDisplayName(statistics: Stats) -> String {
        guard let displayName = statistics.displayName, let displayValue = statistics.displayValue else {
            return ""
        }
        return "\(displayName) - \(displayValue)"
    }
}
