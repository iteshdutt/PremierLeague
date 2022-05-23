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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// This class will set data attributes required for setting the cell
    /// - Parameter singleSeasonAttributes: an instance of PremierLeagueSeasonAttributes
    func setData(seasonAttributes: PremierLeagueSeasonAttributes) {
        self.isUserInteractionEnabled = true
        displayName.text = seasonAttributes.displayName
        displayDate.text = seasonAttributes.leagueSeasonDate
    }
}
