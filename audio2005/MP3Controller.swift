
import UIKit
import AVFoundation
import MediaPlayer


class MP3 {
    
    static var loop = loopTypes[0]
    static var OnlyOnce = false
    
    static var playingItem = Dictionary<String, AnyObject>() //King
    static var outlet : Dictionary<String,AnyObject>{ //Guard of king, only outlet of this class
        get{return playingItem}
        set(item){
            //validCheck item
            if !validCheck(item: item){return}
            //check if duplicated
            if playingItemId == (item[itemId] as! String){return}
            //all other conditions
            playingItem = item
            OnlyOnce = true
        }
    }
    static var playingAlbumId : String{
        guard let id = playingItem[albumId] as? String else {return ""}
        return id
    }
    static var playingItemId : String{
        guard let id = playingItem[itemId] as? String else {return ""}
        return id
    }
    static var playingItems : [Dictionary<String, AnyObject>]{
        return ItemsFactory.getLocalItemsOf(albumId: playingAlbumId)
    }
    static var playingItemIndex:Int{
        var index = 0
        for (i,item) in playingItems.enumerated(){
            guard let id = item[itemId] as? String else {continue}
            if id == playingItemId {index = i; break}
        }
        return index
    }
    
    static func validCheck(item:Dictionary<String, AnyObject>)->Bool{
        
        if (item["newOrOld"] as? String) == "new" {logmark("not permitted 👾"); return false}
        guard let localIdentity = item["localIdentity"] as? String else {logmark("not permitted 👾👾"); return false}
        let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
        if !FileManager.default.fileExists(atPath: localURL.path){logmark("not permitted 👾👾👾"); return false}
        
        return true
    }
    
    static func stagePre(){
        let nowItemIndex = MP3.playingItemIndex
        if nowItemIndex == 0{return}
        let go = nowItemIndex - 1
        MP3.outlet = MP3.playingItems[go]
    }
    static func stageNext(){
        let nowItemIndex = MP3.playingItemIndex
        guard let go = switchNext(nowItemIndex) else {return}
        MP3.outlet = MP3.playingItems[go]
    }
    
    static func switchNext(_ i:Int)->Int?{
        switch loop {
        case loopTypes[0]: //one
            return i
        case loopTypes[1]: //loop
            if i == MP3.playingItems.count-1{return nil}
            return i+1
        case loopTypes[2]: //shuffle
            return _u.random(MP3.playingItems.count)
        default: //"none"
            return nil
        }
    }
    static func switchLoopType(){
        let now = loopTypes.indexes(of: loop)[0]
        if now == loopTypes.count - 1 {
            loop=loopTypes[0]
        }
        else {loop = loopTypes[now + 1] }
    }
    
}

