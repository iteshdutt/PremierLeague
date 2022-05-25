//
//  SeasonTableCell.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation
import UIKit
import SDWebImage

/// This class is subclass of UITableViewCell
class SeasonTableCell: UITableViewCell {
    @IBOutlet var displayName: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var gamePlayed: UILabel!
    @IBOutlet var statsView: UIView!
    @IBOutlet var wins: UILabel!
    @IBOutlet var losses: UILabel!
    @IBOutlet var draws: UILabel!
    @IBOutlet var goalsFor: UILabel!
    @IBOutlet var goalsAgainst: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var goalDifference: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// This class will set data attributes required for setting the cell
    /// - Parameter cellViewModel: an instance of StandingsCellViewModel
    func setData(_ cellViewModel: StandingsCellViewModel) {
        updateUI()
        displayName.text = cellViewModel.displayName
        fetchImageLogo(imageUrl: cellViewModel.imageUrl)
        gamePlayed.text = cellViewModel.stats[3].displayName
        wins.text = cellViewModel.stats[0].displayName
        losses.text = cellViewModel.stats[1].displayName
        draws.text = cellViewModel.stats[2].displayName
        goalsFor.text = cellViewModel.stats[4].displayName
        goalsAgainst.text = cellViewModel.stats[5].displayName
        goalDifference.text = cellViewModel.stats[8].displayName
        points.text = cellViewModel.stats[6].displayName
    }
    
    /// This function will download the image from the given image url
    /// - Parameter imageUrl: an instance of String
    private func fetchImageLogo(imageUrl: String) {
        let urlString = URL.init(string: imageUrl)
        logoImageView?.sd_setImage(with: urlString)
    }
    
    /// This method will update UI of stats view by adding layer properties like border width, corner radius etc
    private func updateUI() {
        statsView.layer.borderWidth = 1;
        statsView.layer.cornerRadius = 10
        statsView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
}
