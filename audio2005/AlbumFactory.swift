//
//  AlbumFactory.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

class AlbumFactory{
    static func getLocalAlbums() -> [Dictionary<String, AnyObject>]{
        guard let albums = db.value(forKey: albumKey) else {
            return [Dictionary<String, AnyObject>]()
        }
        return albums as! [Dictionary<String, AnyObject>]
    }
}
