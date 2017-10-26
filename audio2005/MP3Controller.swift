import Foundation
import AVFoundation
import MediaPlayer

class M: NSObject, AVAudioPlayerDelegate{
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override init(){
        super.init()
        M.enableBackgroundOnce()
        logmark("you shouldn't see this message more than once 💟")
        //TODO: set some thing default to play here to prevent crash.
    }
    func newPlay(itemURL:URL){
        do{
            player = try AVAudioPlayer(contentsOf:itemURL)
            player.prepareToPlay()
            player.delegate = self
            player.play()
        }catch{
            logerr(error)
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        //loghere()
        MP3.playNext()
    }
}


class MP3{
    static let m = M()
    static var loop = loopTypes[1]
    
    static var albumIn = -1
    static var itemIn = -1
    static func setPlay(albumI:Int,itemI:Int){
        albumIn = albumI
        itemIn = itemI
        let items = ItemsFactory.getItemsOf(albumIndex: albumIn)
        playingItems = items
        playingItem = items[itemIn]
        guard let itemURL = playingItem.assetURL else {return}
        m.newPlay(itemURL: itemURL)
    }
    
    static var playingItems = Array<MPMediaItem>()
    static var playingItem = MPMediaItem()
    

    
    static func togglePlay(){
        if m.player.isPlaying { m.player.pause() } else { m.player.play() }
    }
    static func playPre(){
        let nowItemIndex = itemIn
        if nowItemIndex == 0{return}
        let go = nowItemIndex - 1
        setPlay(albumI: albumIn, itemI: go)
    }
    static func playNext(){
        let nowItemIndex = itemIn
        guard let go = switchNext(nowItemIndex) else {return}
        setPlay(albumI: albumIn, itemI: go)
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
    
}


extension M{
    static func enableBackgroundOnce(){
        UIApplication.shared.beginReceivingRemoteControlEvents()
        UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in })
        do { try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback) }
        catch _ {}
    }
    static func enableRemoteOnce(){
        
    }
    
}
