//
//  MainCoordinatorTests.swift
//  horse-racerTests
//

import XCTest
@testable import horse_racer

final class MainCoordinatorTests: XCTestCase {
    
    func test_start() {
        
        // Given
        let nav = UINavigationController()
        let sut = MainCoordinator(navigationController: nav)
        
        // When
        sut.start()
        
        // Then
        XCTAssertTrue(sut.childCoordinators.isEmpty)
        XCTAssertEqual(sut.navigationController, nav)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        
    }
    
    func test_showRaces() {
        
        // Given
        let nav = UINavigationController()
        let sut = MainCoordinator(navigationController: nav)
        
        // When
        sut.showRaces()
        
        // Then
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssertTrue(type(of: sut.childCoordinators.first!) == RaceListCoordinator.self)
        
    }
    
}
