//
//  NewsApiUITests.swift
//  NewsApiUITests
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import XCTest

class NewsApiUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // ilk cell tıklama
    func testExample() {
        let app = XCUIApplication()
        app.tables.cells.element(boundBy: 0).tap()
    }
    
    // cell sayısı
    func testExample1() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssert(count == 0)
    }
    
}
