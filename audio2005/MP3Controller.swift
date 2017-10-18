import Foundation
import AVFoundation
import MediaPlayer

class M: NSObject, AVAudioPlayerDelegate{
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override init() {
        super.init()
        M.enableBackgroundOnce()
        logmark("you shouldn't see this message more than once 💟")
        //TODO: set some thing default to play here to prevent crash.
    }
    func newPlay(){
        let localIdentity = MP3.playingItem["localIdentity"] as! String
        
        let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
        logvar("localURL ✌️", localURL)
        
        do{
            player = try AVAudioPlayer(contentsOf:localURL)
            player.prepareToPlay()
            player.delegate = self
            player.play()
        }catch{
            logerr(error)
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        loghere()
        MP3.playNext()
    }
    
}


class MP3{
    
    static let m = M()

    static var loop = loopTypes[1]
    static var outlet:Dictionary<String, AnyObject>{
        get{return MP3.playingItem}
        set(item){
            //validCheck item
            if !MP3.validCheck(item: item){return}
            //check if duplicated
            if MP3.playingItemId == (item[itemId] as! String){return}
            //all other conditions
            MP3.playingItem = item
            m.newPlay()
        }
    }

    static var playingItem = Dictionary<String, AnyObject>() //King

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
        if m.player.isPlaying { m.player.pause() } else { m.player.play() }
    }
    static func playPre(){
        let nowItemIndex = playingItemIndex
        if nowItemIndex == 0{return}
        let go = nowItemIndex - 1
        outlet = playingItems[go]
    }
    static func playNext(){
        let nowItemIndex = playingItemIndex
        guard let go = switchNext(nowItemIndex) else {return}
        outlet = playingItems[go]
    }
    static func switchNext(_ i:Int)->Int?{
        switch loop {
        case loopTypes[0]: //one
            return i
        case loopTypes[2]: //shuffle
            return _u.random(playingItems.count)
        default : //loop, none
            if i == playingItems.count-1{return nil}
            return i+1
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
    
    

    
    
}


extension M{
    static func enableBackgroundOnce(){
        UIApplication.shared.beginReceivingRemoteControlEvents()
        UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in })
        do { try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback) }
        catch _ {}
    }
    
}
