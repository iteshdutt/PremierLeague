//
//  SeasonDetailsViewController.swift
//  football
//
//  Created by Itesh Dutt on 21/05/22.
//

import UIKit
import SwiftLoader

fileprivate class Constants {
    static public let cellIdentifier = "SeasonTableCellIdentifier"
}

/// This class will display standings for selected year. It is an instance of UIViewController
class SeasonDetailsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var seasonsTableView: UITableView!
    @IBOutlet fileprivate weak var errorView: UIView!
    var viewModel: SeasonDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = viewModel.year
        getSelectedYearStandings()
    }
    
    /// This method will call view model to get standings for selected year.
    fileprivate func getSelectedYearStandings() {
        SwiftLoader.show(title: GlobalConstants.loadingText, animated: true)
        Task {
            do {
                let standings = try await viewModel.getSeasonDetails()
                updateLeagueStandings(standings: standings)
            } catch {
                showHideErrorScreen(showErrorScreen: true)
            }
            SwiftLoader.hide()
        }
    }
    
    /// This function will update the view based on response from api.
    /// - Parameter leagueSeasons: an array of StandingsCellViewModel
    fileprivate func updateLeagueStandings(standings: [StandingsCellViewModel]?) {
        let hasNoData = standings?.isEmpty ?? true
        showHideErrorScreen(showErrorScreen: hasNoData)
        if(!hasNoData) {
            viewModel.standings = standings!
            seasonsTableView.reloadData()
        }
    }
    
    /// This function will show/hide error screen based on response from api.
    /// - Parameter showErrorScreen: bool value
    fileprivate func showHideErrorScreen(showErrorScreen: Bool) {
        if showErrorScreen {
            self.seasonsTableView.isHidden = true
            self.errorView.isHidden = false
        } else {
            self.seasonsTableView.isHidden = false
            self.errorView.isHidden = true
        }
    }
    
    /// In case of error this button will make force api call to get the updated data
    /// - Parameter sender: sender
    @IBAction func tryAgainButtonPressed(sender: UIButton) {
        sender.isUserInteractionEnabled = false
        getSelectedYearStandings()
        sender.isUserInteractionEnabled = true
    }
}

extension SeasonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.standings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? SeasonTableCell, viewModel.standings.count > indexPath.row {
            cell.setData(viewModel.standings[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

