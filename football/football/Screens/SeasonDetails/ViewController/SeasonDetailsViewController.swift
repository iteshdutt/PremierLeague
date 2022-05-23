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
    var year: String!
    fileprivate var seasons = [SingleSeasonAttributes]()
    fileprivate lazy var coordinator = {
        SeasonDetailsCoordinator()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSingleYearLeagueData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = year
    }
    
    /// This method will call coordinator to get standings for selected year.
    fileprivate func getSingleYearLeagueData() {
        SwiftLoader.show(title: GlobalConstants.loadingText, animated: true)
        Task {
            do {
                let seasons = try await coordinator.getSeasonDetails(year: year)
                // Update collection view content
                updateLeagueStandings(leagueSeasons: seasons)
            } catch {
                showHideErrorScreen(showErrorScreen: true)
            }
            SwiftLoader.hide()
        }
    }
    
    /// This function will update the view based on response from api.
    /// - Parameter leagueSeasons: an array of SingleSeasonAttributes
    fileprivate func updateLeagueStandings(leagueSeasons: [SingleSeasonAttributes]) {
        showHideErrorScreen(showErrorScreen: leagueSeasons.isEmpty)
        if(!leagueSeasons.isEmpty) {
            seasons = leagueSeasons
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
        getSingleYearLeagueData()
        sender.isUserInteractionEnabled = true
    }
}

extension SeasonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? SeasonTableCell, seasons.count > indexPath.row {
            cell.setData(singleSeasonAttributes: seasons[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

