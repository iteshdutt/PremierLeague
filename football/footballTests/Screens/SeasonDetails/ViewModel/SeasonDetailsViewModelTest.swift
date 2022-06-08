//
//  SeasonDetailsViewModelTests.swift
//  footballTests
//
//  Created by Itesh Dutt on 23/05/22.
//

import XCTest
@testable import football

class SeasonDetailsViewModelTests: BaseXCTestCase {
    let viewModel = SeasonDetailsViewModel(dataProvider: SeasonDetailsDataProvider())
    let mockViewModel = SeasonDetailsViewModel(dataProvider: MockISeasonDetailsDataProvider())
    let mockErrorViewModel = SeasonDetailsViewModel(dataProvider: MockErrorISeasonDetailsDataProvider())
    
    
    func testGetLeagueDetailsData() async {
        viewModel.year = "2020"
        do {
            let seasons = try await viewModel.getSeasonDetails()
            XCTAssertFalse(seasons?.isEmpty ?? true)
        } catch {
            XCTFail("Api should not fail")
        }
    }
    
    func testMockGetLeagueDetailsData() async {
        mockViewModel.year = "2020"
        do {
            let standings = try await mockViewModel.getSeasonDetails()
            XCTAssertFalse(standings?.isEmpty ?? true)
        } catch {
            XCTFail("Api should not fail")
        }
    }
    
    func testMockErrorGetLeagueDetailsData() async {
        mockErrorViewModel.year = "2020"
        do {
            _ = try await mockErrorViewModel.getSeasonDetails()
            XCTFail("Api should fail")
        } catch let error{
            XCTAssertNotNil(error)
        }
    }
}

class MockISeasonDetailsDataProvider: ISeasonDetailsDataProvider {
    func getSelectedSeasonDetails(year: String, completion: @escaping ([StandingsCellViewModel]?, ClientError?) -> ()) {
        completion([
            StandingsCellViewModel(displayName: "Machester United", imageUrl: "", stats: [StatsAttributes(displayName: "Wins - 38")])
        ], nil)
    }
}

class MockErrorISeasonDetailsDataProvider: ISeasonDetailsDataProvider {
    func getSelectedSeasonDetails(year: String, completion: @escaping ([StandingsCellViewModel]?, ClientError?) -> ()) {
        completion(nil, .invalidResponse)
    }
}
