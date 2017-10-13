
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
        logvar("removing albumIds", albumIds)
        for theAlbumId in albumIds{
            ItemsFactory.removeItemsOf(theAlbumId: theAlbumId)
        }
        db.removeObject(forKey:albumKey)
    }

    
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
        for theAlbumId in albumIds{
            let items = ItemsFactory.getLocalItemsOf(albumId: theAlbumId)
            logvar("items.count", items.count)
            for (index,item) in items.enumerated(){
                var newItems = items  //to secure mutation
                let theItemId = item[itemId] as! String
                if (item["newOrOld"] as! String) == "old"{continue}
                if (downloadingList.contains(theItemId)==true) {logmark("dup attemped, downloadAll_r");continue}
                if downloadingList.count==2{return}
                if downloadingList.count==0{/*downloadAll_r()*/}
                
                downloadingList.append(theItemId)
                logvar("downloadingList", downloadingList)
                ItemsFactory.downloadOne(item: item, fn: { localURL in
                    var newItem = item //to secure mutation
                    newItem["newOrOld"] = "old" as AnyObject
                    newItem["localURL"] = localURL.absoluteString as AnyObject
                    
                    newItems[index] = newItem
                    db.set(newItems, forKey:theAlbumId)

                    downloadingList = downloadingList.filter {$0 != theItemId}
                    //downloadAll_r()
                })
                return
            }
            return
        }
    }
}












