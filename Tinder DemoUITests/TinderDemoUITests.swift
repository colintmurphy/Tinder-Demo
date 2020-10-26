//
//  TinderDemoUITests.swift
//  Tinder DemoUITests
//
//  Created by Colin Murphy on 10/23/20.
//

import XCTest

class TinderDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation
        // - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSwipeRight() {
        //let app = XCUIApplication()
        //app.launch()
        //let swipeableView = app.windows.element(matching: .any, identifier: "SwipeableView")
        //swipeableView.swipeRight()
    }

    func testSwipeLeft() {
        //let app = XCUIApplication()
        //app.launch()
        //let swipeableView = app.windows.element(matching: .any, identifier: "SwipeableView")
        //swipeableView.swipeLeft()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

