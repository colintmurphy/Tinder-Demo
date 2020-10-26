//
//  SwipeableViewTests.swift
//  Tinder DemoTests
//
//  Created by Colin Murphy on 10/26/20.
//

import XCTest
@testable import Tinder_Demo

//swiftlint:disable trailing_whitespace

class SwipeableViewTests: XCTestCase {
    
    var swipeableView: SwipeableView?

    override func setUpWithError() throws {
        swipeableView = SwipeableView()
    }
    override func tearDownWithError() throws {
        swipeableView = nil
    }

    func testExample() {
        //swipeableView.g
    }
}
