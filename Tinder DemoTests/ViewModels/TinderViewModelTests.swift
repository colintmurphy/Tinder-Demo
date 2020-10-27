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

    private var testClass: TinderViewTestClass?
    private var rect: CGRect?
    private var viewModel: TinderViewModel?
    private var users: [User]?
    
    override func setUpWithError() throws {
        testClass = TinderViewTestClass()
        rect = CGRect(x: 0, y: 0, width: 100, height: 200)
        viewModel = TinderViewModel(viewModelDelegate: testClass!, containerViewBounds: rect!)
        users = [User(name: Name(first: "Colin", last: "Murphy"),
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
                     picture: nil)]
    }
    override func tearDownWithError() throws {
        testClass = nil
        rect = nil
        viewModel = nil
        users = nil
    }
    
    // MARK: - Add Card

    func testAddCardToView() {
        let card = CardView()
        viewModel?.viewModelDelegate?.addCardToContainer(card: card, at: 0)
        XCTAssertEqual(testClass?.view.subviews.count, 1)
    }
    
    // MARK: - Get Connect
    
    func testGetConnectAtIndex() {
        guard let users = users else { return }
        viewModel?.connectsList = users
        let user = viewModel?.getConnect(at: 0)
        XCTAssertEqual(user?.fullName, "Colin Murphy")
    }
    
    func testGetNilConnectAtIndex() {
        let user = viewModel?.getConnect(at: 0)
        XCTAssertNil(user)
    }
    
    // MARK: - Get Connect Count
    
    func testGetConnectsCount() {
        guard let users = users else { return }
        viewModel?.connectsList = users
        let count = viewModel?.getConnectsCount()
        XCTAssertEqual(count, 3)
    }
    
    func testGetZeroConnectsCount() {
        let count = viewModel?.getConnectsCount()
        XCTAssertEqual(count, 0)
    }
    
    // MARK: - Swipes
    
    func testSwipeLeft() {
        guard let users = users else { return }
        viewModel?.usersInContainer = users
        let cardView = CardView()
        viewModel?.cardViews = [cardView]
        viewModel?.didSwipeLeft(on: cardView)
        let count = viewModel?.getConnectsCount()
        XCTAssertEqual(count, 0)
    }
    
    func testSwipeRight() {
        guard let users = users else { return }
        viewModel?.usersInContainer = users
        let cardView = CardView()
        viewModel?.cardViews = [cardView]
        viewModel?.didSwipeRight(on: cardView)
        let count = viewModel?.getConnectsCount()
        XCTAssertEqual(count, 1)
    }
}

fileprivate class TinderViewTestClass: TinderViewModelDelegate {
    
    var view = UIView()
    
    func failed(error: TinderError) { }
    
    func addCardToContainer(card: CardView, at index: Int) {
        view.insertSubview(card, at: index)
    }
}
