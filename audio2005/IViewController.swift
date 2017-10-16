

import UIKit

class IViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{

    var Albums : [Dictionary<String, AnyObject>]{
        get{return AlbumFactory.getLocalAlbums()}
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func removeAll(_ sender: UIButton) {
        AlbumFactory.removeEverything()
        self.collectionView.reloadData()
    }
    
    
    @IBAction func download_r(_ sender: UIButton) {
        AlbumFactory.testing_block=true
        AlbumFactory.downloading_r=true
        AlbumFactory.downloadAll_r()
    }
    override func loadView() {
        super.loadView()
        //logvar("Albums.count", Albums.count)
    }
    
    //Mark: View Display and interaction
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int {return Albums.count+1}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! albumCell
        albumCell.albumImage.image = UIImage(named: albumCovers[indexPath.row])
        albumCell.imageLabel.text = albumCovers[indexPath.row] //should be album name
        albumCell.isUserInteractionEnabled=true

        return albumCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.prepReq()
        default:
            goToView2(indexPath.row-1)
        }
    }
    
    @objc func goToView2(_ index:Int){ //print("go to second view here")
        if index <= Albums.count{
            guard let chosenAlbumId = Albums[index]["albumid"] as? String else {return}
            AlbumFactory.viewAlbumId = chosenAlbumId
            logmark("Going to album: \(chosenAlbumId)")
            self.performSegue(withIdentifier: "toSecond", sender: self)
        }else{logmark("index out of range, what's wrong?")}
        
    }
    
    @objc func prepReq(){
        let alert = _c.userinput(title: "For Sync", message: "Enter yoru code") { code in
            self.reqFile(obj:["code":code as String])
        }
        self.present(alert, animated: false)
    }
    
    func reqFile(obj:Dictionary<String, String>){
        FactoryHttpInterface.getFiles(obj:obj){ data in
            
            //Mark: all three asynch here should have their ways of detecting already downloaded files
            //Checked
            // TODO: disable cliciking into album if content not fullied downloaded.
            //TODO: downloading progress
            AlbumFactory.updateLocalAlbums(data:data[albumKey])
            ItemsFactory.updateLocalItems(data:data)
            
//            AlbumFactory.downloadAll_r()


            DispatchQueue.main.async{self.collectionView.reloadData()}

        }
    }

    
}

class albumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
}
