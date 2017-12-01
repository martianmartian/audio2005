

import UIKit
import AVFoundation
import MediaPlayer

class IIIViewController: UIViewController {

    var notInited:Bool{return MP3.itemIn == -1}
    var timer = Timer()
    var bookmarks = [Dictionary<String,AnyObject>]()
    
    @IBOutlet weak var bookmarkcount: UILabel!
    
    @IBOutlet weak var nowTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var switchLoopType: UIButton!
    @IBOutlet weak var nowplaying: UILabel!
    
    @IBOutlet weak var playCtrl: UIButton!
    @IBOutlet weak var preCtrl: UIButton!
    @IBOutlet weak var nextCtrl: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
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
    
    @IBAction func slided(_ sender: UISlider, forEvent event: UIEvent) {
        if notInited {return}
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .ended:
                let currentTime = MP3.m.player.duration * Double(sender.value)
                MP3.m.player.currentTime = currentTime
            default:
                break
            }
        }
    }
    func jumpto(t:Int){
        if notInited {return}
        
        var go = Float(0)
        let to = Float(MP3.m.player.currentTime) + Float(t)
        
        if to<0 { go = 0 }
        else if to > Float(MP3.m.player.duration){ go = Float(MP3.m.player.duration)}
        else{ go = to }

        MP3.m.player.currentTime = Double(go)
        updateViewFreq()
    }
    
    @IBAction func left1(_ sender: UIButton) { jumpto(t: -5) }
    
    @IBAction func left2(_ sender: UIButton) { jumpto(t: -30) }
    
    @IBAction func left3(_ sender: UIButton) { jumpto(t: -60) }
    
    @IBAction func right1(_ sender: UIButton) { jumpto(t: 5) }
    
    @IBAction func right2(_ sender: UIButton) { jumpto(t: 30) }
    
    @IBAction func right3(_ sender: UIButton) { jumpto(t: 60) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayerView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
        super.viewWillDisappear(false)
    }
}

extension IIIViewController{
    
}








extension IIIViewController{
    //Mark: Timer stuff
    func startTimer(){
        if notInited {return};
        timer.invalidate()
        timer = _u.setInterval(0.5){self.updateViewFreq()};
        logmark("timer started")
    }
    func stopTimer(){
        if notInited {return};
        timer.invalidate()
        logmark("timer stopped")
    }
    
    
    //Mark: view update stuff
    func updateViewFreq(){
        if notInited {return}
        let time1 = M.calculateTimeFromNSTimeInterval(MP3.m.player.currentTime)
        nowTime?.text = "\(time1.minute):\(time1.second)"
        slider.setValue(Float(MP3.m.player.currentTime/MP3.playingItem.playbackDuration), animated: true)
    }
    func updatePlayerView(){
        if notInited {return}
        
        //Bookmarks
        bookmarks = ItemsFactory.getBookmarksOf(item: MP3.playingItem)
        bookmarkcount?.text = "Total bookmarks: " + String(bookmarks.count)
        
        
        //others
        switchLoopType.setImage(UIImage(named: MP3.loop), for: [])
        nowplaying?.text = MP3.playingItem.title
        
        //Mark: time display
        let time2 = M.calculateTimeFromNSTimeInterval(MP3.playingItem.playbackDuration)
        totalTime?.text = "\(time2.minute):\(time2.second)"
        
        //Mark: play button
        if MP3.m.player.isPlaying {playCtrl.setImage(UIImage(named:"pause"), for: []);startTimer()}
        else {playCtrl.setImage(UIImage(named:"play"), for: []);stopTimer()}
        
    }
}





