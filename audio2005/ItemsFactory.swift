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
    
    static func getLocalItemsOf(albumId:String) -> [Dictionary<String, AnyObject>]{
        guard let items = db.value(forKey:albumId) else {
            return [Dictionary<String, AnyObject>]()
        }
        return items as! [Dictionary<String, AnyObject>]
    }
    
    static func getItemsOf(albumIndex:Int) -> Array<MPMediaItem>{
        
        let albums = AlbumFactory.getMediaAlbums()

        let album = albums[albumIndex]
        let items = album.items

        return items
    }

}














