//
//  NewsApiTests.swift
//  NewsApiTests
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import XCTest
@testable import NewsApi

class NewsApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // isInternetControl
    func testExample() {
        let sourcesTableViewController = SourcesTableViewController()
        
        XCTAssertEqual(sourcesTableViewController.isNetworkConnectivityAvailable(), true)

    }
    
    // service call
    func testExample1() {
        API.makeCall("/v2/sources?"){ (result) in
            print(result)
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
