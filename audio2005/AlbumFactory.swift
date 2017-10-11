//
//  AlbumFactory.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

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
        let ids = _u.pluck(data: AlbumFactory.getLocalAlbums(), key:albumKey)
        return ids
    }
    
    static func updateLocalAlbums(data:AnyObject?){

        //step one, check if nil from server. could be a wrong code!
        guard let data = data as? [Dictionary<String, AnyObject>] else { logmark() ;return}
        
        var gotAlbums = AlbumFactory.getLocalAlbums()
        let ids = AlbumFactory.getLocalAlbumIds()
        
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
}
