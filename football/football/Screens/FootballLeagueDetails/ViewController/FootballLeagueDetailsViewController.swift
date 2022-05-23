//
//  FootballLeagueDetailsViewController.swift
//  football
//
//  Created by Itesh Dutt on 21/05/22.
//

import UIKit
import SwiftLoader

fileprivate class Constants {
    static public let cellIdentifier = "PremierLeagueSeasonTableCellIdentifier"
    static public let loadingText = "Loading..."
    static public let premierLeague = "Premier League"
}

/// This class will display premier league details year wise. It is an instance of UIViewController
class FootballLeagueDetailsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var seasonsTableView: UITableView!
    @IBOutlet fileprivate weak var errorView: UIView!
    fileprivate var seasons = [PremierLeagueSeasonAttributes]()
    fileprivate lazy var coordinator = {
        FootballLeagueDetailsCoordinator(viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.premierLeague
        getLeagueData()
    }
    
    /// This method will call coordinator to get premier league data
    fileprivate func getLeagueData() {
        SwiftLoader.show(title: Constants.loadingText, animated: true)
        Task {
            do {
                let seasons = try await coordinator.getLeagueDetailsData()
                // Update collection view content
                updatePremierLeagueData(leagueSeasons: seasons)
            } catch {
                showHideErrorScreen(showErrorScreen: true)
            }
            SwiftLoader.hide()
        }
    }
    
    /// This function will update the view based on response from api.
    /// - Parameter leagueSeasons: an array of PremierLeagueSeasonAttributes
    fileprivate func updatePremierLeagueData(leagueSeasons: [PremierLeagueSeasonAttributes]) {
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
        getLeagueData()
        sender.isUserInteractionEnabled = true
    }
}

extension FootballLeagueDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? PremierLeagueSeasonTableCell, seasons.count > indexPath.row {
            cell.setData(seasonAttributes: seasons[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if seasons.count > indexPath.row {
            let season = seasons[indexPath.row]
            coordinator.navigateToDetailsScreen(year: season.year)
        }
    }
}

