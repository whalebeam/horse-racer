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
    
    func test_raceListViewController_state_loading() {
        
        // Given I init the controller with no model data
        let sut = RaceListViewController()
        
        // When
        sut.state = .loading
        
        // Then
        sut.loadingView.isHidden = true
        
    }
    
    func test_raceListViewController_state_error() {
        
        // Given
        let sut = RaceListViewController()
        let errorView = sut.errorView
        
        // When
        sut.state = .error
        
        // Then
        XCTAssertTrue(sut.view.subviews.contains(errorView))
        
    }
    
    func test_raceListViewController_state_success() {
        
        // Given
        let sut = RaceListViewController()
        let dummyModel = [Race(name: "test", courseName: "test", age: "", time: "test")]
        
        // When
        sut.state = .success(dummyModel)
        
        // Then
        XCTAssertFalse(sut.tableView.refreshControl!.isRefreshing)
        
    }
    
}
