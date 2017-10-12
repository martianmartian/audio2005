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
        
        let albumIds = AlbumFactory.getLocalAlbumIds()
        for album in gotAlbums{
            //here it disable the website from deleting item;
            //so it only put in the new ones, check if missing item, and skip this step
            
            guard let theid = album[albumId] as? String else {logmark();continue}
            
            if albumIds.contains(theid) {
                // case: stricly UPDATING the album. theid already exist.
                // get a list of item ids outside this loop.
                // check items of each album and only put in new ones.
                // watch out for more potential problems.
            }else{
                // case: it's new album, set without dup check
                guard let albumItems = data[theid] as? [Dictionary<String,AnyObject>] else{logmark();continue}
                //there's a problem here: item's mp3 might be lost
                //this approach only works for first time loading items
                db.set(albumItems,forKey:theid)
            }
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

    static var downloadingList = [String]()
    static func downloadOne(item:Dictionary<String,AnyObject>,fn:@escaping(_ localURL:URL)->()){
    /*
    //check if already downloaded: newOrOld
    //?? check if triggered twice???yes
         
         //cache how many are being downloaded
         //limit to 2 at the same time
         
    //if not in downloadinglist, add it
    //start downloading
         //callback(localURL):
    */
        if (item["newOrOld"] as? String) == "old"{logmark("dup download attemped");return}
        guard let id = item[itemId] as? String else{logmark("empty item???");return}
        if(downloadingList.contains(id)==true){logmark("dup download-ing attemped");return}
        downloadingList.append(id)
        FactoryHttpInterface.downloadOne(id:id){ localURL in
            logvar("localURL", localURL)
            downloadingList = downloadingList.filter {$0 != id}
            fn(localURL)
        }
    }
    
}














