//
//  NetworkManagerTests.swift
//  Tinder DemoTests
//
//  Created by Colin Murphy on 10/23/20.
//

import XCTest
@testable import Tinder_Demo

//swiftlint:disable trailing_whitespace

class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testUserFetchedSuccess() {
        
        let expectation = XCTestExpectation(description: "fetch random user")
        NetworkManager.shared.fetchUsers(RandomUserResponse.self) { results in
            switch results {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testDownloadAndCacheImageSuccess() {
        downloadImage()
        downloadImage()
    }
    
    func downloadImage() {
        let expectation = XCTestExpectation(description: "download user image")
        NetworkManager.shared.downloadImage(with: "https://randomuser.me/api/portraits/men/27.jpg") { results in
            switch results {
            case .success(let image):
                XCTAssertNotNil(image)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testUserSwipeLeft() { }
}
