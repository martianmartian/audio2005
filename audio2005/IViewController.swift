

import UIKit
import MediaPlayer

class IViewController: UIViewController{

    var Albums = AlbumFactory.getMediaAlbums()
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logvar("Albums", Albums)
        setupCollectionView()
    }
    
}
extension IViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    override func loadView() { UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation");super.loadView()}
    override var shouldAutorotate: Bool { return false }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 5
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(albumCell.self, forCellWithReuseIdentifier: "albumCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = false
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,insetForSectionAt section: Int)->UIEdgeInsets { return UIEdgeInsetsMake(18, 0, 0, 0) }
    func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int{return Albums.count}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = Albums[indexPath.row]
        let name = album.value(forProperty: MPMediaPlaylistPropertyName) as! String
        
        let albumCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! albumCell
        albumCell.awakeFromNib()
        albumCell.im.image = UIImage(named: albumCovers[indexPath.row])
        albumCell.codedLabel.text = name
        albumCell.isUserInteractionEnabled=true
        
        return albumCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)->CGSize {
        let w = (collectionView.frame.size.width-20) / 3
        return CGSize(width: CGFloat(w), height: CGFloat(w+20))
//        return CGSize(width: view.frame.width/4, height: view.frame.width/4 + 20)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        logmark("Going to album: \(indexPath.row)")
        IIVCData.viewAlbumIndex = indexPath.row
        self.performSegue(withIdentifier: "oneTotwo", sender: self)
    }
    
}
class albumCell: UICollectionViewCell {
    var im : UIImageView!
    var codedLabel : UILabel!
    
    override func awakeFromNib() {
        im = UIImageView()
        im.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        im.contentMode = .scaleAspectFit
        im.clipsToBounds = true
        
        self.contentView.addSubview(im)
        
        codedLabel = UILabel()
        codedLabel.contentMode = .bottom
        codedLabel.frame = CGRect(x: 0, y: frame.width, width: frame.width, height: 20)
        codedLabel.textAlignment = .center
        codedLabel.numberOfLines=1
        //codedLabel.textColor=UIColor.white
        //codedLabel.backgroundColor=UIColor.blue
        self.contentView.addSubview(codedLabel)
        //Remember to add UI Element to the contentView, not the cell itself
    }
}
