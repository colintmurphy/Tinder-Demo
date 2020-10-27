//
//  ConnectsViewModelTests.swift
//  Tinder DemoTests
//
//  Created by Colin Murphy on 10/26/20.
//

import XCTest
@testable import Tinder_Demo

//swiftlint:disable trailing_whitespace

class ConnectsViewModelTests: XCTestCase {
    
    fileprivate var testData: ConnectsDataSourceTestClass?
    fileprivate var connectViewModel: ConnectsViewModel?

    override func setUpWithError() throws {
        testData = ConnectsDataSourceTestClass()
        connectViewModel = ConnectsViewModel(dataSource: testData)
    }
    override func tearDownWithError() throws {
        testData = nil
        connectViewModel = nil
    }

    func testUserCount() {
        guard let count = connectViewModel?.getConnectsCount() else { return }
        XCTAssertEqual(count, 3)
    }
    
    func testUserCountWithNilDataSource() {
        testData = nil
        guard let count = connectViewModel?.getConnectsCount() else { return }
        XCTAssertEqual(count, 0)
    }
    
    func testGetProperUser() {
        guard let user = connectViewModel?.getUser(at: 1) else { return }
        XCTAssertEqual(user.fullName, "Dave Johnson")
    }
}

fileprivate class ConnectsDataSourceTestClass: ConnectsDataSource {
    
    let users: [User] = [
        User(name: Name(first: "Colin", last: "Murphy"),
             location: nil,
             birth: nil,
             picture: nil),
        User(name: Name(first: "Dave", last: "Johnson"),
             location: nil,
             birth: nil,
             picture: nil),
        User(name: Name(first: "Mark", last: "Miller"),
             location: nil,
             birth: nil,
             picture: nil)
    ]
    
    func getConnectsCount() -> Int {
        return users.count
    }
    
    func getConnect(at index: Int) -> User? {
        return users[index]
    }
}
