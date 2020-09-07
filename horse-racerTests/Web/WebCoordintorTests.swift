//
//  WebCoordintorTests.swift
//  horse-racerTests
//


import XCTest
@testable import horse_racer

final class WebCoordinatorTests: XCTestCase {
    
    func test_start() {
        
        
        let nav = UINavigationController()
        let sut = WebCoordinator(navigationController: nav, url: URL(string: "https://duckduckgo.com")!)
        let promise = expectation(description: "I expect not to be called because viewDidLoad has not been called since the navigation controller isn't on screen")
        promise.isInverted = true
        
        sut.viewController.load = { _ in
            promise.fulfill()
            return .none
        }
        
        sut.start()
        
        XCTAssertEqual(nav.viewControllers.count, 1)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
