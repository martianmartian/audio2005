//
//  ItemsFactory.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation
import MediaPlayer

class ItemsFactory{
    
    static func getBookmarksOf(item:MPMediaItem) -> [Dictionary<String,AnyObject>]{
        let itemId = String(item.persistentID)
        print(itemId)
        guard let bookmarks = db.value(forKey:itemId) as? [Dictionary<String,AnyObject>] else{
            return [Dictionary<String,AnyObject>]()
        }
        return bookmarks
    }
    static func addBookmarkFor(item:MPMediaItem, bookmark:Dictionary<String,AnyObject>){
        //id: [Dictionary(id:String(123),"t":Float(0),"mark":"somewords")]
        //step1: extract
        //step2: insert
        //step3: update
        var bookmarks = getBookmarksOf(item: item)
        bookmarks.insert(bookmark, at: bookmarks.endIndex)
        let itemId = String(item.persistentID)
        logvar("itemId", itemId)
        db.set(bookmarks, forKey:itemId)
    }
    static func removeBookmarkFor(item:MPMediaItem){}
    static func proneBookmarks(){
        //loop through all and remove ones no longer exist.
        //only execute at demand or at launch.
    }
    
    
    static func getItemsOf(albumIndex:Int) -> Array<MPMediaItem>{
        
        let albums = AlbumFactory.getMediaAlbums()

        let album = albums[albumIndex]
        let items = album.items
        
        return items
    }

}














