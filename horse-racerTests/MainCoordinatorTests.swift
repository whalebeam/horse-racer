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
    
}
