
import Foundation

class AlbumFactory{
    
    static var viewAlbumId = String()
    
    static func getLocalAlbums() -> [Dictionary<String, AnyObject>]{
        guard let albums = db.value(forKey: albumKey) as? [Dictionary<String, AnyObject>] else {
            return [Dictionary<String, AnyObject>]()
        }
        return albums
    }
    
    static func getLocalAlbumIds() -> [String]{
        let ids = _u.pluck(data: getLocalAlbums(), key:albumId)
        return ids
    }
    
    static func updateLocalAlbums(data:AnyObject?){

        /*step one, check if nil from server. could be a wrong code!*/
        guard let data = data as? [Dictionary<String, AnyObject>] else { logmark() ;return}
        
        var gotAlbums = getLocalAlbums()
        let ids = getLocalAlbumIds()
        
        for one in data{
            var one = one

            guard let theid = one[albumId] as? String else {logmark();continue}
            if ids.contains(theid) {print("\nupdateLocalAlbums dupped \(theid) -----\n");continue}

            one["createdAt"] = NSDate()

            gotAlbums.append(one)
        }
        db.set(gotAlbums, forKey:albumKey)
        
        print("------ new Albums set, if any")
        
    }

    static func removeEverything(){
        let albumIds = AlbumFactory.getLocalAlbumIds()
        logvar("😈😈😈removing albumIds", albumIds)

        for theAlbumId in albumIds{
            ItemsFactory.removeItemsOf(theAlbumId: theAlbumId)
        }
        db.removeObject(forKey:albumKey)
    }

    
    static var testing_block = false
    static var downloading_r = true
    static var downloadingList = [String]()
    static func downloadAll_r(){
        /* recursively download all items, 2 at a time
        get all album ids
        loop one, album ids                     keep id accessible
            loop two, album items               keep (index, item) accssible
                (check downloadingList, max two)
                if old, continue
                if in it, continue
                if max(full), return
                if two left(empty), call self, go on
                if one left,
                    append ONE id
                    start downloadOne{ localUrl in
                        update item info
                             a few things.
                        update items array
                        save album's items
                        remove id from downloadingList
                        call self
                     }
                 return
            return
        */
        let albumIds = getLocalAlbumIds()
        logvar("albumIds:🍀🍀🍀🍀🍀🍀🍀🍀", albumIds)
        for theAlbumId in albumIds{
            let items = ItemsFactory.getLocalItemsOf(albumId: theAlbumId)
            logone("items.count 🍀🍀", items.count, active:testing_block)
            logone("theAlbumId 🍀🍀", theAlbumId, active:testing_block)
            var newItems = items
            for (index,item) in items.enumerated(){
                if downloadingList.count==2{logmark("inside💛 max downloading allowed ");return}
                if (item["newOrOld"] as! String) == "old"{
                    logone("pass old🍋🍋🍋",item[itemId] as! String, active:testing_block)
                    continue
                }
                let theItemId = item[itemId] as! String
                if (downloadingList.contains(theItemId)==true) {logmark("dup concurrency attemped🍋🍋🍋");continue}
                downloadingList.append(theItemId)
                logone("💚💚new attempt item: ", theItemId)
                logone("downloadingList", downloadingList,"\n")
                ItemsFactory.downloadOne(item:item){localIdentity in
                    var newItem = item //to secure mutation
                    newItem["newOrOld"] = "old" as AnyObject
                    newItem["localIdentity"] = localIdentity as AnyObject
                    logvar("✅✅✅✅successfully downloaded:",localIdentity)
                    
                    newItems[index] = newItem
                    db.set(newItems, forKey:theAlbumId)
                    
                    downloadingList = downloadingList.filter {$0 != theItemId}
                    if downloading_r{downloadAll_r()}
                }
            }
        }
    }
}












