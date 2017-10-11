//
//  FactoriesTests.swift
//  audio2005Tests
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest
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
        FactoryHttpInterface.getFiles(obj:["code":"323" as AnyObject]){ result in
            logvar("result", result)
            expect.fulfill()
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    func testMainFactory_downloadOne(){
//        let expect = expectation(description: "download one should work")
//        FactoryHttpInterface.downloadOne(id:"cd5b8ee5-b415-cb4b-cf8c-bfb97cbc62d8")
//        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
