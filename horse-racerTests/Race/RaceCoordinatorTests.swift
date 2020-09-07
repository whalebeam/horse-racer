//
//  RaceCoordinatorTests.swift
//  horse-racerTests
//


import UIKit

import XCTest

@testable import horse_racer

final class RaceCoordinatorTests: XCTestCase {
    
    let race = Race(
        name: "Maiden Plate (F & M)",
        courseName: "Vaal",
        rides: [
            Ride(clothNumber: 1,
                 formSummary: "",
                 currentOdds: "",
                 horse: Horse(
                    name: "",
                    daysSinceLastRun: 1,
                    foaled: "",
                    sex: ""),
                 url: "")
        ]
    )
    
    
    func test_start() {
        
        // Given
        
        let nav = UINavigationController()
        let sut = RaceCoordinator(navigationController: nav, race: race)
        
        
        sut.start()
        
        XCTAssertEqual(sut.viewController.title, "Maiden Plate (F & M)")
        XCTAssert(sut.viewController.coordinator === sut)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        
    }
    
}
