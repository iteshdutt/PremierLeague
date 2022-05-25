//
//  FootbalLeagueDetailsNavigationHandler.swift
//  football
//
//  Created by Itesh Dutt on 22/05/22.
//

import Foundation
import UIKit

fileprivate class Constants {
    static public let identifier = "SeasonDetailsViewController"
}

/// This class is responsible for routing
class FootballLeagueDetailsNavigationHandler {
    weak var viewController: FootballLeagueDetailsViewController!
    
    init(controller: FootballLeagueDetailsViewController) {
        self.viewController = controller
    }
    
    /// This will route the user to season Details screen
    /// - Parameter year: year
    func routeToDetailsScreen(year: Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: GlobalConstants.storyBoard, bundle:nil)
        let seasonDetailsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.identifier) as! SeasonDetailsViewController
        let viewModel = SeasonDetailsViewModel.init(dataProvider: SeasonDetailsDataProvider())
        viewModel.year = String(year)
        seasonDetailsViewController.viewModel = viewModel
        viewController.navigationController?.pushViewController(seasonDetailsViewController, animated: true)
    }
}
