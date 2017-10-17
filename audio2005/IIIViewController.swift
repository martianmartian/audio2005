

import UIKit
import AVFoundation
import MediaPlayer

class IIIViewController: UIViewController {
//
//    var playingItem = MP3.playingItem
//    var playingAlbumId = MP3.playingAlbumId
//    var playingItemId = MP3.playingItemId
//    var playingItems = MP3.playingItems
//    var playingItemIndex = MP3.playingItemIndex
    
    
    @IBAction func startPlay(_ sender: UIButton) {
        MP3.togglePlay()
    }
    
    @IBAction func playPre(_ sender: UIButton) {
        MP3.playPre()
    }
    
    @IBAction func playNext(_ sender: UIButton) {
        MP3.playNext()
    }
    
    @IBAction func switchLoopType(_ sender: UIButton) {
        MP3.switchLoopType()
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
    }

    @IBOutlet weak var switchLoopType: UIButton!
    @IBOutlet weak var nowplaying: UILabel!
    override func viewDidLoad() {
        

        
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
        if let name = MP3.playingItem["itemName"] as? String{
            nowplaying?.text = name
        }
    }
}



