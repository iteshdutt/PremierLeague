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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// This class will set data attributes required for setting the cell
    /// - Parameter singleSeasonAttributes: an instance of SingleSeasonAttributes
    func setData(singleSeasonAttributes: SingleSeasonAttributes) {
        updateUI()
        displayName.text = singleSeasonAttributes.displayName
        fetchImageLogo(imageUrl: singleSeasonAttributes.imageUrl)
        gamePlayed.text = singleSeasonAttributes.stats[3].displayName
        wins.text = singleSeasonAttributes.stats[0].displayName
        losses.text = singleSeasonAttributes.stats[1].displayName
        draws.text = singleSeasonAttributes.stats[2].displayName
        goalsFor.text = singleSeasonAttributes.stats[4].displayName
        goalsAgainst.text = singleSeasonAttributes.stats[5].displayName
        goalDifference.text = singleSeasonAttributes.stats[8].displayName
        points.text = singleSeasonAttributes.stats[6].displayName
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
