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
    fileprivate lazy var viewModel: FootballLeagueDetailsViewModel = {
        FootballLeagueDetailsViewModel(viewController: self, dataProvider: FootballLeagueDetailsDataProvider())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.premierLeague
        getLeagueData()
    }
    
    /// This method will call view model to get premier league data
    fileprivate func getLeagueData() {
        SwiftLoader.show(title: Constants.loadingText, animated: true)
        Task {
            do {
                let seasons = try await viewModel.getLeagueDetailsData()
                updatePremierLeagueSeasons(leagueSeasons: seasons)
            } catch {
                showHideErrorScreen(showErrorScreen: true)
            }
            SwiftLoader.hide()
        }
    }
    
    /// This function will update the view based on response from api.
    /// - Parameter leagueSeasons: an array of LeagueSeasonsCellViewModel
    fileprivate func updatePremierLeagueSeasons(leagueSeasons: [LeagueSeasonsCellViewModel]?) {
        let hasNoData = leagueSeasons?.isEmpty ?? true
        showHideErrorScreen(showErrorScreen: hasNoData)
        if(!hasNoData) {
            viewModel.seasons = leagueSeasons!
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
        return viewModel.seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? PremierLeagueSeasonTableCell, viewModel.seasons.count > indexPath.row {
            let cellViewModel = viewModel.seasons[indexPath.row]
            cell.setData(cellViewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.seasons.count > indexPath.row {
            let season = viewModel.seasons[indexPath.row]
            viewModel.navigateToDetailsScreen(year: season.year)
        }
    }
}

