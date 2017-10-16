
import AVFoundation

class MP3{
    static var player: AVAudioPlayer?
    static var playingItem = Dictionary<String, AnyObject>() //King
    static var outlet : Dictionary<String,AnyObject>{ //Guard of king, only outlet of this class
        get{return playingItem}
        set(item){
            //validCheck item
            if !validCheck(item: item){return}
            //check if duplicated
            if playingItemId == (item[itemId] as! String){return}
            //all other conditions
            resetPlayer(item:item);
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

    
    
    static func validCheck(item:Dictionary<String, AnyObject>)->Bool{
        
        if (item["newOrOld"] as? String) == "new" {logmark("not permitted 👾"); return false}
        guard let localIdentity = item["localIdentity"] as? String else {logmark("not permitted 👾👾"); return false}
        let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
        if !FileManager.default.fileExists(atPath: localURL.path){logmark("not permitted 👾👾👾"); return false}
        
        return true
    }
    
    static func resetPlayer(item:Dictionary<String,AnyObject>){
        
        playingItem = item
        
        let localIdentity = playingItem["localIdentity"] as! String
        
        let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
        logvar("localURL ✌️", localURL)

        do{
            player = try AVAudioPlayer(contentsOf:localURL)
            player?.play()
        }catch{
            print(error)
        }
    }
    
    
}

