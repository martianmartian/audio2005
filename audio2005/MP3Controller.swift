
import AVFoundation

class MP3{
    static var player: AVAudioPlayer = AVAudioPlayer()
    static var playItem = Dictionary<String, AnyObject>()
    
    static var playAlbumId : String{
        guard let id = MP3.playItem[albumId] as? String else {return ""}
        return id
    }
    static var playItemId : String{
        guard let id = MP3.playItem[itemId] as? String else {return ""}
        return id
    }
    
    static var playItems : [Dictionary<String, AnyObject>]{
        return ItemsFactory.getLocalItemsOf(albumId: MP3.playAlbumId)
    }
    
    
    
}

