//
//  FootballLeagueDetailsViewModelTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 23/05/22.
//

import XCTest
@testable import football

class FootballLeagueDetailsViewModelTests: BaseXCTestCase {
    let viewModel: FootballLeagueDetailsViewModel = FootballLeagueDetailsViewModel(viewController: FootballLeagueDetailsViewController(), dataProvider: FootballLeagueDetailsDataProvider())
    let mockViewModel: FootballLeagueDetailsViewModel = FootballLeagueDetailsViewModel(viewController: FootballLeagueDetailsViewController(), dataProvider: MockIFootballLeagueDetailsDataProvider())
    let mockErrorViewModel: FootballLeagueDetailsViewModel = FootballLeagueDetailsViewModel(viewController: FootballLeagueDetailsViewController(), dataProvider: MockErrorIFootballLeagueDetailsDataProvider())
    
    
    func testGetLeagueDetailsData() async {
        do {
            let seasons = try await viewModel.getLeagueDetailsData()
            XCTAssertFalse(seasons?.isEmpty ?? true)
        } catch {
            XCTFail("Api should not fail")
        }
    }
    
    func testMockGetLeagueDetailsData() async {
        do {
            let seasons = try await mockViewModel.getLeagueDetailsData()
            XCTAssertFalse(seasons?.isEmpty ?? true)
        } catch {
            XCTFail("Api should not fail")
        }
    }
    
    func testMockErrorGetLeagueDetailsData() async {
        do {
            _ = try await mockErrorViewModel.getLeagueDetailsData()
            XCTFail("Api should fail")
        } catch let error{
            XCTAssertNotNil(error)
        }
    }
}

class MockIFootballLeagueDetailsDataProvider: IFootballLeagueDetailsDataProvider {
    func getLeagueDetails(completion: @escaping ([LeagueSeasonsCellViewModel]?, ClientError?) -> ()) {
        completion([
            LeagueSeasonsCellViewModel(displayName: "Premier league", leagueSeasonDate: "1/Jun/2020 - 01/Jun/2021", year: 2020),
            LeagueSeasonsCellViewModel(displayName: "Premier league", leagueSeasonDate: "1/Jun/2019 - 01/Jun/2020", year: 2019)
        ], nil)
    }
}

class MockErrorIFootballLeagueDetailsDataProvider: IFootballLeagueDetailsDataProvider {
    func getLeagueDetails(completion: @escaping ([LeagueSeasonsCellViewModel]?, ClientError?) -> ()) {
        completion(nil, .invalidResponse)
    }
}
