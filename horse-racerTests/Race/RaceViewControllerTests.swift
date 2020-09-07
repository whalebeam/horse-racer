//
//  RaceViewControllerTests.swift
//  horse-racerTests
//


import XCTest
@testable import horse_racer

final class RaceViewControllerTests: XCTestCase {
    
    func test_init_tableView_isConfigured() {
        
        let sut = RaceListViewController()
        
        XCTAssertNil(sut.tableView.delegate)
        XCTAssertNil(sut.tableView.dataSource)
        
        
        // When
        sut.loadView()
        
        
        // Then
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(sut.tableView.rowHeight, UITableView.automaticDimension)
        XCTAssertEqual(sut.tableView.estimatedRowHeight, 120)
        XCTAssert(sut.tableView.delegate === sut)
        
    }
    
    
    
}
