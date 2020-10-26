//
//  UserTests.swift
//  Tinder DemoTests
//
//  Created by Colin Murphy on 10/26/20.
//

import XCTest
@testable import Tinder_Demo

//swiftlint:disable trailing_whitespace

class UserTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }
    
    // MARK: - Name

    func testUserSuccessFull() {
        let user = User(name: Name(first: "Colin", last: "Murphy"),
                        location: Location(city: "Wilmington", state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin Murphy")
        XCTAssertEqual(user.fullLocation, "Wilmington, Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    // MARK: First Name
    
    func testUserSuccessMissingFirstName() {
        let user = User(name: Name(first: nil, last: "Murphy"),
                        location: Location(city: "Wilmington", state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "")
        XCTAssertEqual(user.fullLocation, "Wilmington, Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    func testUserSuccessEmptyFirstName() {
        let user = User(name: Name(first: "", last: "Murphy"),
                        location: Location(city: "Wilmington", state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "")
        XCTAssertEqual(user.fullLocation, "Wilmington, Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    // MARK: - Last Name
    
    func testUserSuccessMissingLastName() {
        let user = User(name: Name(first: "Colin", last: nil),
                        location: Location(city: "Wilmington", state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin")
        XCTAssertEqual(user.fullLocation, "Wilmington, Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    func testUserSuccessEmptyLastName() {
        let user = User(name: Name(first: "Colin", last: ""),
                        location: Location(city: "Wilmington", state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin")
        XCTAssertEqual(user.fullLocation, "Wilmington, Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    // MARK: - Location
    
    func testUserSuccessMissingState() {
        let user = User(name: Name(first: "Colin", last: "Murphy"),
                        location: Location(city: "Wilmington", state: nil),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin Murphy")
        XCTAssertEqual(user.fullLocation, "Wilmington")
        XCTAssertEqual(user.age, "22")
    }
    
    func testUserSuccessEmptyState() {
        let user = User(name: Name(first: "Colin", last: "Murphy"),
                        location: Location(city: "Wilmington", state: ""),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin Murphy")
        XCTAssertEqual(user.fullLocation, "Wilmington")
        XCTAssertEqual(user.age, "22")
    }
    
    func testUserSuccessMissingCity() {
        let user = User(name: Name(first: "Colin", last: "Murphy"),
                        location: Location(city: nil, state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin Murphy")
        XCTAssertEqual(user.fullLocation, "Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    func testUserSuccessEmptyCity() {
        let user = User(name: Name(first: "Colin", last: "Murphy"),
                        location: Location(city: "", state: "Delaware"),
                        birth: Birth(date: nil, age: 22),
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin Murphy")
        XCTAssertEqual(user.fullLocation, "Delaware")
        XCTAssertEqual(user.age, "22")
    }
    
    // MARK: - Age
    
    func testUserSuccessMissingAge() {
        let user = User(name: Name(first: "Colin", last: "Murphy"),
                        location: Location(city: "Wilmington", state: "Delaware"),
                        birth: nil,
                        picture: nil)
        XCTAssertEqual(user.fullName, "Colin Murphy")
        XCTAssertEqual(user.fullLocation, "Wilmington, Delaware")
        XCTAssertEqual(user.age, "")
    }
}
