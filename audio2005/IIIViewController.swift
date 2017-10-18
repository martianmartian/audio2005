

import UIKit
import AVFoundation
import MediaPlayer

class IIIViewController: UIViewController {

    @IBAction func startPlay(_ sender: UIButton) {
        if notInited {return}
        MP3.togglePlay()
        updatePlayerView()
    }
    
    @IBAction func playPre(_ sender: UIButton) {
        if notInited {return}
        MP3.playPre()
        updatePlayerView()
    }
    
    @IBAction func playNext(_ sender: UIButton) {
        if notInited {return}
        MP3.playNext()
        updatePlayerView()
    }

    @IBAction func switchLoopType(_ sender: UIButton) {
        MP3.switchLoopType()
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
    }

    @IBOutlet weak var switchLoopType: UIButton!
    @IBOutlet weak var nowplaying: UILabel!

    override func viewDidLoad() {
        switchLoopType.setImage(UIImage(named: MP3.loop), for: [])
        
        updatePlayerView()
    }

    var notInited:Bool{
        if MP3.playingItem["localIdentity"] == nil {return true}
        return false
    }
    func updatePlayerView(){
        if let name = MP3.playingItem["itemName"] as? String{
            nowplaying?.text = name
        }
    }

}



