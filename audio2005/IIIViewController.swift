

import UIKit
import AVFoundation
import MediaPlayer

class IIIVCData{
    static var playAlbumIndex = 0
    static var playItemIndex = 0
}

class IIIViewController: UIViewController {

    @IBOutlet weak var nowTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var switchLoopType: UIButton!
    @IBOutlet weak var nowplaying: UILabel!
    
    @IBOutlet weak var playCtrl: UIButton!
    @IBOutlet weak var preCtrl: UIButton!
    @IBOutlet weak var nextCtrl: UIButton!
    
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
    var notInited:Bool{return MP3.itemIn == -1}

    
    override func viewDidLoad() {
        switchLoopType.setImage(UIImage(named: MP3.loop), for: [])
        updatePlayerView()
    }


    //make a decorator out of this updating function
    func updatePlayerView(){
        if notInited {return}
        nowTime?.text = String(MP3.m.player.currentTime)
        totalTime?.text = String(MP3.playingItem.playbackDuration/60)
        if MP3.m.player.isPlaying {playCtrl.setImage(UIImage(named:"pause"), for: [])}
        else {playCtrl.setImage(UIImage(named:"play"), for: [])}
        updateViewFreq()
    }
    func updateViewFreq(){
        if notInited {return}
        nowplaying?.text = MP3.playingItem.title
    }
    
    

}









