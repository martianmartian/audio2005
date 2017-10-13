
import XCTest
import Foundation
import Alamofire
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
        
        FactoryHttpInterface.downloadOne(id:id){ localURL in
            logvar("localURL", localURL)
            XCTAssertNotNil(localURL)
            expect.fulfill()

            //remove it after done!!!!!!!!!!!!!!!
            var item = Dictionary<String,AnyObject>()
            item["localURL"] = localURL as AnyObject
            ItemsFactory.removeMp3Of(item:item)
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
        ItemsFactory.downloadOne(item:item){localURL in
            logvar("localURL", localURL)
            XCTAssertNotNil(localURL)
            expect.fulfill()
            
            //remove it after done!!!!!!!!!!!!!!!
            item["localURL"] = localURL.absoluteString as AnyObject
            ItemsFactory.removeMp3Of(item:item)
            XCTAssertFalse(FileManager.default.fileExists(atPath:localURL.path))
        }
        /* test of duplicated download. don't remove
        ItemsFactory.downloadOne(item:item as [String:AnyObject]){localURL in
            logvar("localURL", localURL)
            XCTAssertNotNil(localURL)
        }
        */
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error)
        }
    }
    

    
}
