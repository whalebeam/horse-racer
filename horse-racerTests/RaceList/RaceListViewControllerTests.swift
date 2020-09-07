//
//  RaceViewControllerTests.swift
//  horse-racerTests
//

import XCTest
@testable import horse_racer

final class RaceListViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_tableView_isConfigured() {
        
        // Given
        let sut = RaceListViewController()
        
        XCTAssertNil(sut.tableView.delegate)
        XCTAssertNil(sut.tableView.dataSource)
        
        // When
        sut.loadView()
        
        // Then
        
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        XCTAssertEqual(sut.tableView.rowHeight, UITableView.automaticDimension)
        XCTAssertEqual(sut.tableView.estimatedRowHeight, 120)
        
    }
    
    func test_raceListViewController_state_success() {
        
        // Given
        let sut = RaceListViewController()
        let dummyModel: [Race] = []
        
        // When
        sut.state = .success(dummyModel)
        
        // Then
        XCTAssertFalse(sut.tableView.refreshControl!.isRefreshing)
        
    }
    
}
