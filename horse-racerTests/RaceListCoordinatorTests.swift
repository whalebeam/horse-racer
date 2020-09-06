//
//  RaceListCoordinatorTests.swift
//  horse-racerTests
//

import XCTest
@testable import horse_racer

final class RaceListCoordinatorTests: XCTestCase {
    
    func test_start() {
        
        // Given
        let nav = UINavigationController()
        let sut = RaceListCoordinator(navigationController: nav, raceListViewController: RaceListViewController())
        
        // When
        sut.start()
        
        // Then
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        XCTAssertEqual(sut.viewController.title, "Live Races")
        XCTAssert(sut.viewController.coordinator === sut)
        
    }
    
    func test_fetch() {
        // TODO: once networking is setup
    }
    
}
