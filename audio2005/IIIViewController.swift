

import UIKit
import AVFoundation
import MediaPlayer

class IIIViewController: UIViewController, AVAudioPlayerDelegate {

    var player: AVAudioPlayer? = nil
    

    @IBAction func togglePlay(_ sender: UIButton) {
        if player == nil{return}
        if player!.isPlaying {player!.pause()}
        else {player!.play()}
    }
    
    @IBAction func playPre(_ sender: UIButton) {
        if player == nil{return}
        MP3.stagePre()
        resetPlayer()
    }
    
    @IBAction func playNext(_ sender: UIButton) {
        if player == nil { logmark("trying to play empty list");return}
        MP3.stageNext()
        resetPlayer()
    }
    
    @IBAction func switchLoopType(_ sender: UIButton) {
        MP3.switchLoopType()
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
    }

    @IBOutlet weak var switchLoopType: UIButton!
    @IBOutlet weak var nowplaying: UILabel!
    
    override func viewDidLoad() {
        
        if let image = UIImage(named: MP3.loop) { switchLoopType.setImage(image, for: []) }
        loadAudioView()
        
        if MP3.OnlyOnce == true {
            MP3.OnlyOnce=false
            resetPlayer()
            enablebackground()
        }
    }
    func resetPlayer(){
        
        let localIdentity = MP3.outlet["localIdentity"] as! String
        
        let localURL = _u.getLocalURLFrom(localIdentity: localIdentity)
        logvar("localURL ✌️", localURL)
        
        do{
            
            player = try AVAudioPlayer(contentsOf:localURL)
            player!.prepareToPlay()
            player!.delegate = self
            player!.play()
            loadAudioView()
            
        }catch{
            logerr(error)
        }
        
    }
    func loadAudioView(){
        if let name = MP3.playingItem["itemName"] as? String{
            nowplaying?.text = name
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true{
            MP3.stageNext()
            resetPlayer()
        }
    }

    func enablebackground(){
        UIApplication.shared.beginReceivingRemoteControlEvents()
        UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in })
        do { try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback) }
        catch _ {}
    }

    
    
}



