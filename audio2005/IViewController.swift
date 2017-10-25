

import UIKit
import MediaPlayer

class IViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{

    var Albums = AlbumFactory.getMediaAlbums()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func loadView() {
        super.loadView()
        logvar("Albums", Albums)
        
//        let query = MPMediaQuery.playlists()
//        guard let albums = query.collections else {return}
//        let album = albums[0]
//        let items = album.items
//        print(type(of: items))
//
        
    }
    
    //Mark: View Display and interaction
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int {return Albums.count}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = Albums[indexPath.row]
        let name = album.value(forProperty: MPMediaPlaylistPropertyName) as! String
        
        let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! albumCell
        albumCell.albumImage.image = UIImage(named: albumCovers[indexPath.row])
        albumCell.imageLabel.text = name
        albumCell.isUserInteractionEnabled=true

        return albumCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        IIVCData.viewAlbumIndex = indexPath.row
        logmark("Going to album: \(indexPath.row)")
        self.performSegue(withIdentifier: "oneTotwo", sender: self)
    }
    
}

class albumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
}
