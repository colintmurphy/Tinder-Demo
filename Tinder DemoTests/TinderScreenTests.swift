//
//  TinderScreenTests.swift
//  Tinder DemoTests
//
//  Created by Colin Murphy on 10/25/20.
//

import XCTest
@testable import Tinder_Demo

class TinderScreenTests: XCTestCase {

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
    
    func testSwipeRight() {
        let view = SwipeableView()
        view.delegate?.didSwipeRight(on: view)
    }
    
    func testSwipeLeft() {
        let view = SwipeableView()
        view.delegate?.didSwipeLeft(on: view)
    }
}
