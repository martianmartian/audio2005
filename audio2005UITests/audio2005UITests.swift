//
//  audio2005UITests.swift
//  audio2005UITests
//
//  Created by martian2049 on 10/10/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest
@testable import audio2005

class audio2005UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    
    func testFlow() {
        //Rount one:
            //launch
            //get album, check
            //remove album, check
        let collectionView = app.collectionViews

        let firstChild = collectionView.children(matching:.any).element(boundBy: 0)
        XCTAssert(firstChild.exists)
        firstChild.tap()

        let thealert = app.staticTexts["For Sync"]
        XCTAssert(thealert.exists)

        let textField = app.textFields["code"]
        XCTAssert(textField.exists)

        textField.typeText("323")
        let action = app.buttons["OK"]
        XCTAssert(action.exists)
        action.tap()

        
        sleep(3)
        XCTAssertEqual(collectionView.cells.count, 2)
        collectionView.cells.element(boundBy: 1).tap()
        
        
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.swipeRight()
        
        app.buttons["Remove All"].tap()
        XCTAssertEqual(collectionView.cells.count, 1)
        
    }
    func testIIVController(){

    }
    
}
