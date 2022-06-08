//
//  BaseXCTestCase.swift
//  footballTests
//
//  Created by Itesh Dutt on 07/06/22.
//

import XCTest

class BaseXCTestCase: XCTestCase {
    func loadJson(filename fileName: String, fileType: String = "json") -> Data? {
        if let url = Bundle(for: FootballLeagueDetailsRequestTest.self).url(forResource: fileName, withExtension: fileType) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
