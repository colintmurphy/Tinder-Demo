//
//  TinderViewModelTests.swift
//  Tinder DemoTests
//
//  Created by Colin Murphy on 10/26/20.
//

import XCTest
@testable import Tinder_Demo

//swiftlint:disable trailing_whitespace

class TinderViewModelTests: XCTestCase {

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testUsersDownloadSuccess() throws {
        let expectation = XCTestExpectation(description: "fetch users in TinderViewModel")
        let delegate = TinderViewController()
        let model = TinderViewModel(delegate: delegate)
        
        //expectation.fulfill()
        //wait(for: [expectation], timeout: 3.0)
    }
}
