//
//  WebViewControllerTests.swift
//  horse-racerTests
//

import XCTest
@testable import horse_racer

final class WebViewControllerTests: XCTestCase {
    
    func test_webView_didLoad() {
        
        // Given
        let sut = WebViewController(url: URL(string: "https://duckduckgo.com")!)
        let promise = expectation(description: "I expect load to be called on the webview")
        
        sut.load = { request in
            XCTAssertEqual(request.url?.absoluteString, "https://duckduckgo.com")
            promise.fulfill()
            return .none
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
