//
//  iTunesAppUITests.swift
//  iTunesAppUITests
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import XCTest

class DetailViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSearchBarAndDetailButton() {
        
        app.searchBarField.tap()
        XCTAssertTrue(app.searchBarField.exists)
        app.searchBarField.typeText("Tarkan")
        app.keyboards.buttons["Search"].tap()
        let cell = app.tableView.cells.element(boundBy: 2)
        XCTAssertTrue(app.tableView.exists)
        cell.tap()
        sleep(1)
        app.playAndStopButton.tap()
        XCTAssertTrue(app.playAndStopButton.exists)
        
    }
}

extension XCUIApplication {
    var searchBarField: XCUIElement {
            searchFields["homeSearchBar"]
        }
    var tableView: XCUIElement {
            tables["homeTableView"]
        }
    var playAndStopButton: XCUIElement {
            buttons["detailPlayAndStopButton"]
        }
}
