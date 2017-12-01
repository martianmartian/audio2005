//
//  AlbumFactoryTests.swift
//  audio2005Tests
//
//  Created by martian2049 on 10/13/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import XCTest
import Foundation

@testable import audio2005

class AlbumFactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    override func tearDown() {
        super.tearDown()
    }
    func testFiles_Download() {

        let expect = expectation(description: "File Download should work")
        FactoryHttpInterface.getFiles(obj:["code":"836"]){ data in
            //logvar("files result", data)

            AlbumFactory.updateLocalAlbums(data:data[albumKey])
            ItemsFactory.updateLocalItems(data:data)

            let albumIds = AlbumFactory.getLocalAlbumIds()
            XCTAssertNotEqual(albumIds.count, 0)
            let itemsIdsOfAlbum = ItemsFactory.getLocalItemsOf(albumId: albumIds[0])
            XCTAssertNotEqual(itemsIdsOfAlbum.count, 0)

            expect.fulfill()
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }

    }
    func testMp3_Download(){
        
        AlbumFactory.testing_block=true
        AlbumFactory.downloading_r=true
        AlbumFactory.downloadAll_r()
        
        let expect = expectation(description: "Check MP3 download")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            let howmany1 = _u.countMP3atRoot()
            XCTAssertNotEqual(howmany1, 0)
            XCTAssertEqual(howmany1, 7)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testRemove(){
        
        AlbumFactory.removeEverything()
        let albumIds = AlbumFactory.getLocalAlbumIds()
        XCTAssertEqual(albumIds.count, 0)
        
        let howmany0 = _u.countMP3atRoot()
        XCTAssertEqual(howmany0, 0)
        
    }
    
}










