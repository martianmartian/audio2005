
import AVFoundation
import MediaPlayer
//AVAudioPlayerDelegate


class MP3: NSObject, AVAudioPlayerDelegate{
    static var player: AVAudioPlayer?
    static var loop = loopTypes[0]
    
    
    
    static var playingItem = Dictionary<String, AnyObject>() //King
    static var outlet : Dictionary<String,AnyObject>{ //Guard of king, only outlet of this class
        get{return playingItem}
        set(item){
            //validCheck item
            if !validCheck(item: item){return}
            //check if duplicated
            if playingItemId == (item[itemId] as! String){return}
            //all other conditions
            resetPlayer(item:item)
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
    
    
    static func togglePlay(){
        if player == nil { logmark("trying to play empty list");return}
        if (player?.isPlaying)!{ player?.pause() } else { player?.play() }
    }
    static func playPre(){
        if player == nil { logmark("trying to play empty list");return}
        let nowItemIndex = playingItemIndex
        if nowItemIndex == 0{return}
        let go = nowItemIndex - 1
        outlet = playingItems[go]
    }
    @objc static func playNext(){
        if player == nil { logmark("trying to play empty list");return}
        let nowItemIndex = playingItemIndex
        guard let go = switchNext(nowItemIndex) else {return}
        outlet = playingItems[go]
    }
    static func switchNext(_ i:Int)->Int?{
        switch loop {
        case loopTypes[0]: //one
            return i
        case loopTypes[1]: //loop
            if i == playingItems.count-1{return nil}
            return i+1
        case loopTypes[2]: //shuffle
            return _u.random(playingItems.count)
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
            player?.prepareToPlay()
//            player?.delegate = self
            player?.play()
        }catch{
            logerr(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
        } catch {
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        loghere()
        
    }
    
    
}

