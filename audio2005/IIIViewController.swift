

import UIKit
import AVFoundation
import MediaPlayer

class IIIViewController: UIViewController {

    @IBAction func startPlay(_ sender: UIButton) {
        if notInited {return}
        MP3.togglePlay()
    }
    
    @IBAction func playPre(_ sender: UIButton) {
        if notInited {return}
        MP3.playPre()
        self.loadView()
    }
    
    @IBAction func playNext(_ sender: UIButton) {
        if notInited {return}
        MP3.playNext()
        self.loadView()
    }

    @IBAction func switchLoopType(_ sender: UIButton) {
        MP3.switchLoopType()
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
    }

    @IBOutlet weak var switchLoopType: UIButton!
    @IBOutlet weak var nowplaying: UILabel!

    override func loadView() {
        super.loadView()
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
        if let name = MP3.playingItem["itemName"] as? String{
            nowplaying?.text = name
        }
    }
    var notInited:Bool{
        if MP3.playingItem["localIdentity"] == nil {return true}
        return false
    }

}



