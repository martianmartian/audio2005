//
//  ItemsFactory.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//
import Foundation

class ItemsFactory{
    
    static func getLocalItemsOf(albumId:String) -> [Dictionary<String, AnyObject>]{
        guard let items = db.value(forKey:albumId) else {
            return [Dictionary<String, AnyObject>]()
        }
        return items as! [Dictionary<String, AnyObject>]
    }
    
    static func updateLocalItems(data:[String: AnyObject]?){
        //step one, check if nil from server. could be a wrong code!
        guard let data = data else { logmark() ;return}
        guard let gotAlbums = data[albumKey] as? [Dictionary<String, AnyObject>] else { logmark() ;return}
        
        //itemsOfGotAlbum
        let gotAlbumsIds = _u.pluck(data: gotAlbums, key: albumId)
        for theid in gotAlbumsIds{
            //here it disable the website from deleting item;
            //so it only put in the new ones, check if missing item, and skip this step
            
            if var oldItemsArr = db.value(forKey: theid) as? [Dictionary<String,AnyObject>]{
                // case: stricly UPDATING the album. theid already exist.
                // get a list of item ids outside this loop.
                // check items of each album and only put in new ones.
                // watch out for more potential problems.
                let oldItemsIds = _u.pluck(data: oldItemsArr, key: itemId)
                guard let newItems = data[theid] as? [Dictionary<String,AnyObject>] else {continue}
                for newItem in newItems{
                    guard let newItemId = newItem[itemId] as? String else {continue}
                    if oldItemsIds.contains(newItemId){continue}
                    oldItemsArr.append(newItem)
                }
                db.set(oldItemsArr,forKey:theid)
            }else{
                // case: it's new album, set without dup check
                guard let albumItems = data[theid] as? [Dictionary<String,AnyObject>] else{logmark();continue}
                //there's a problem here: item's mp3 might be lost
                //this approach only works for first time loading items
                db.set(albumItems,forKey:theid)
            }
        }
        
    }
    
    static func removeJustTheItem(item:Dictionary<String,AnyObject>){
        //untested yet
        if (item["newOrOld"] as! String) == "old" {removeMp3Of(item: item)}
        //unfinished
        
    }

    static func removeItemsOf(theAlbumId:String){
        let items = ItemsFactory.getLocalItemsOf(albumId: theAlbumId)
        for item in items{
            removeMp3Of(item: item)
        }
        db.removeObject(forKey: theAlbumId)
    }


    static func removeMp3Of(item:Dictionary<String,AnyObject>){
        
        guard let localIdentity = item["localIdentity"] as? String else {logmark("bug 👾👾👾 or un-downloaded? 🔵"); return}

        let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)

        if FileManager.default.fileExists(atPath: localURL.path){
            do{
                try FileManager.default.removeItem(at: localURL)
            }
            catch let error as NSError{print("\nerror--->: ",error.localizedDescription)}
        }else{
            logmark("not there")
            logvar("localURL.path", localURL.path)
        }
    }
    
//    static func downloadAlbum(id:String){ dismiss this one
//        //get the album by id
//        //loop through the items
//        //cache how many are being downloaded
//            //limit to 2 at the same tile
//        //downloadOne(item)
//        //downloadOne(item)  only the next, if there is
//            //remove it's own id from cache
//            //???recursively call this function until finished all?
//        let items = ItemsFactory.getLocalItemsOf(albumId: id)
//        for item in items{
//            
//        }
//    }


    static func downloadOne(item:Dictionary<String,AnyObject>,fn:@escaping(_ localIdentity:String)->()){
        
        guard let id = item[itemId] as? String else{logmark("empty item???👾👾👾");return}
        //logvar("id⁉️", id)
        FactoryHttpInterface.downloadOne(id:id){ localIdentity in
            logvar("localIdentity", localIdentity)

            fn(localIdentity)
        }
    }
    
}














