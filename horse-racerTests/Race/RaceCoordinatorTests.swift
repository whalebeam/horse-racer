//
//  RaceCoordinatorTests.swift
//  horse-racerTests
//


import UIKit

import XCTest

@testable import horse_racer

final class RaceCoordinatorTests: XCTestCase {
    
    let race = Race(name: "Hello World", courseName: "", age: nil, distance: nil, time: nil, rideCount: nil, raceStage: nil, going: nil, rides: [])
    
    
    func test_start() {
        
        // Given
        
        let nav = UINavigationController()
        let sut = RaceCoordinator(navigationController: nav, race: race)
        
        
        sut.start()
        
        XCTAssertEqual(sut.viewController.title, "Hello World")
        XCTAssert(sut.viewController.coordinator === sut)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        
    }
    
}
