//
//  audio2005UITests.swift
//  audio2005UITests
//
//  Created by martian2049 on 10/10/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest

class audio2005UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        app.launch()
    }
    
    func testFiles_Download(){

        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
        let img = app.images["0"]
        XCTAssert(img.exists)
        XCTAssert(firstChild.exists)
        firstChild.tap()
        
        let thealert = app.staticTexts["For Sync"]
        XCTAssert(thealert.exists)
        
        let textField = app.textFields["code"]
        XCTAssert(textField.exists)
        
        textField.typeText("836")
        let action = app.buttons["OK"]
        XCTAssert(action.exists)
        action.tap()
        sleep(1)
        //after file download, the collection should be 2
        XCTAssertNotEqual(app.collectionViews.cells.count, 1)
    }

    
    func testMp3_Download(){

        let downloadbutton = app.buttons["Download All"]
        XCTAssert(downloadbutton.exists)
        downloadbutton.tap()

        let expect = expectation(description: "Check MP3 download")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            expect.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }

    }

    func testSecondView(){
        app.collectionViews.cells.element(boundBy: 2).tap()

        let firstrow = app.tables.children(matching:.any).element(boundBy: 0)
        XCTAssert(firstrow.exists)

        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.swipeRight()
    }

    func testRemove(){

        let deletebutton = app.buttons["Remove All"]
        XCTAssert(deletebutton.exists)
        deletebutton.tap()
        
        XCTAssertEqual(app.collectionViews.cells.count, 1)

    }
    
}
