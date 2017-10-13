//
//  AlbumFactoryTests.swift
//  audio2005Tests
//
//  Created by martian2049 on 10/13/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest
import Foundation
import Alamofire
@testable import audio2005

class AlbumFactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code  here. This method is called after the invocation of each test method in the class.
//        AlbumFactory.removeEverything()
//        let albumIds = AlbumFactory.getLocalAlbumIds()
//        XCTAssertEqual(albumIds.count, 0)
        
        super.tearDown()
    }
    
    func testAlbum_Download_Remove() {
        
        AlbumFactory.removeEverything()
        let albumIds = AlbumFactory.getLocalAlbumIds()
        XCTAssertEqual(albumIds.count, 0)

        let expect = expectation(description: "Request should succeed")
        FactoryHttpInterface.getFiles(obj:["code":"836"]){ data in
            //logvar("files result", data)
            expect.fulfill()

            AlbumFactory.updateLocalAlbums(data:data[albumKey])
            ItemsFactory.updateLocalItems(data:data)

            sleep(1)
            let albumIds = AlbumFactory.getLocalAlbumIds()
            XCTAssertNotEqual(albumIds.count, 0)
            let itemsIdsOfAlbum = ItemsFactory.getLocalItemsOf(albumId: albumIds[0])
            XCTAssertNotEqual(itemsIdsOfAlbum.count, 0)

            AlbumFactory.downloadAll_r()
            sleep(5)

        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }

    }
    
    
}
