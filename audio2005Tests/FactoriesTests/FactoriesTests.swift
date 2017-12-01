
import XCTest
import Foundation

@testable import audio2005

class FactoriesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumFactory(){
        XCTAssertNotNil(AlbumFactory.getLocalAlbums())
    }
    
    func testInterFace_getFiles() {
        let expect = expectation(description: "Request should succeed")
        FactoryHttpInterface.getFiles(obj:["code":"323"]){ result in
            logvar("files result", result)
            expect.fulfill()
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testInterFace_downloadOne(){
        let expect = expectation(description: "download one should work")
        let id = "cd5b8ee5-b415-cb4b-cf8c-bfb97cbc62d8"
        let itemProto = [
            "newOrOld":"new",
            "itemId":"cd5b8ee5-b415-cb4b-cf8c-bfb97cbc62d8"
        ]
        var item = itemProto as [String:AnyObject]
        FactoryHttpInterface.downloadOne(id:id){ localIdentity in
            logvar("localURL🍷🍷🍷", localIdentity)
            XCTAssertNotNil(localIdentity)
            expect.fulfill()

            //remove it after done!!!!!!!!!!!!!!!
            item["localIdentity"] = localIdentity as AnyObject
            ItemsFactory.removeMp3Of(item:item)
            let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
            XCTAssertFalse(FileManager.default.fileExists(atPath:localURL.path))
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    func testItemsFactory_downloadOne(){
        let itemProto = [
            "newOrOld":"new",
            "itemId":"cd5b8ee5-b415-cb4b-cf8c-bfb97cbc62d8"
        ]
        var item = itemProto as [String:AnyObject]
        let expect = expectation(description: "download one should work")
        ItemsFactory.downloadOne(item:item){localIdentity in
            logvar("localIdentity🍷🍷🍷", localIdentity)
            XCTAssertNotNil(localIdentity)
            expect.fulfill()
            
            //remove it after done!!!!!!!!!!!!!!!
            item["localIdentity"] = localIdentity as AnyObject
            ItemsFactory.removeMp3Of(item:item)
            let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
            XCTAssertFalse(FileManager.default.fileExists(atPath:localURL.path))
        }
        
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    

    
}
