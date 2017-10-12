//
//  FactoriesTests.swift
//  audio2005Tests
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest
import Foundation
@testable import audio2005

class FactoriesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumFactory(){
        XCTAssertNotNil(AlbumFactory.getLocalAlbums())
    }
    
    func testMainFactory_getFiles() {
        let expect = expectation(description: "Request should succeed")
        FactoryHttpInterface.getFiles(obj:["code":"323"]){ result in
//            logvar("files result", result)
            expect.fulfill()
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testMainFactory_downloadOne(){
        let expect = expectation(description: "download one should work")
        let id = "cd5b8ee5-b415-cb4b-cf8c-bfb97cbc62d8"
        FactoryHttpInterface.downloadOne(id:id){ localURL in
            XCTAssertNotNil(localURL)
            expect.fulfill()
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    func testItemsFactory_downloadOne(){
        let item = [
            "newOrNot":"0",
            "itemId":"cd5b8ee5-b415-cb4b-cf8c-bfb97cbc62d8"
        ]
        let expect = expectation(description: "download one should work")
        ItemsFactory.downloadOne(item:item as [String:AnyObject]){localURL in
            logvar("localURL", localURL)
            XCTAssertNotNil(localURL)
            expect.fulfill()
            //remove the downloaded things at the end!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        }
        ItemsFactory.downloadOne(item:item as [String:AnyObject]){localURL in
            logvar("localURL", localURL)
            XCTAssertNotNil(localURL)
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
