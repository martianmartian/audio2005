//
//  audio2005UITestsII.swift
//  audio2005UITests
//
//  Created by martian2049 on 10/16/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest

class audio2005UITestsII: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testAudio_setup(){
        app.buttons["Remove All"].tap()
        app.collectionViews.children(matching:.any).element(boundBy: 0).tap()
        app.textFields["code"].typeText("836")
        app.buttons["OK"].tap()
        sleep(1)
        app.buttons["Download All"].tap()
        let expect = expectation(description: "Check MP3 download")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5){expect.fulfill()}
        waitForExpectations(timeout: 5) { (error) in XCTAssertNil(error)}
        
    }
    
    func testAudio_play() {
        
        //go to viewII
        app.collectionViews.cells.element(boundBy: 2).tap()
        //go to viewIII
        let firstrow = app.tables.children(matching:.any).element(boundBy: 0)
        XCTAssert(firstrow.exists)
        firstrow.tap()
        
        let thirdVLabel = app.staticTexts["3"]
        XCTAssert(thirdVLabel.exists)
        // now check on the func on viewIII
        
        
        
        
    }
}





