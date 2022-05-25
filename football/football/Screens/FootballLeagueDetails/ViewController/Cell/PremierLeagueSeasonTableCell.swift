//
//  PremierLeagueSeasonTableCell.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation
import UIKit

/// This class is subclass of UITableViewCell
class PremierLeagueSeasonTableCell: UITableViewCell {
    @IBOutlet var displayName: UILabel!
    @IBOutlet var displayDate: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// This class will set data attributes required for setting the cell
    /// - Parameter cellViewModel: an instance of LeagueSeasonsCellViewModel
    func setData(_ cellViewModel: LeagueSeasonsCellViewModel) {
        self.isUserInteractionEnabled = true
        displayName.text = cellViewModel.displayName
        displayDate.text = cellViewModel.leagueSeasonDate
    }
}
