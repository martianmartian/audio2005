

import UIKit

class IViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{

    var Albums : [Dictionary<String, AnyObject>]{
        get{return AlbumFactory.getLocalAlbums()}
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func removeAll(_ sender: UIButton) {
        MainFactory.removeEverything()
        self.collectionView.reloadData()
    }
    override func loadView() {
        super.loadView()
        //logvar("Albums.count", Albums.count)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int {return Albums.count+1}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! albumCell
        albumCell.albumImage.image = UIImage(named: albumCovers[indexPath.row])
        albumCell.imageLabel.text = albumCovers[indexPath.row]
        albumCell.isUserInteractionEnabled=true
//        let CellTap:UITapGestureRecognizer
//        if indexPath.row == 0{
//            //Mark: the first addition button
//            CellTap = UITapGestureRecognizer(target:self,action:#selector(IViewController.prepReq))
//        }else{
//            //Mark: albums
//            CellTap = UITapGestureRecognizer(target:self,action:#selector(IViewController.goToView2))
//            albumCell.tag = indexPath.row-1
//        }
//        albumCell.addGestureRecognizer(CellTap)
        return albumCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    @objc func goToView2(_ gesture:AnyObject){ //print("go to second view here")
        let tag = gesture.view!.tag
        
        guard let chosenAlbumId = Albums[tag]["albumid"] as? String else {return}
        AlbumFactory.viewAlbumId = chosenAlbumId
        logmark(mark: "Going to album: \(chosenAlbumId)")
        self.performSegue(withIdentifier: "toSecond", sender: self)
    }
    
    @objc func prepReq(){
        let alert = _c.userinput(title: "For Sync", message: "Enter yoru code") { code in
            self.reqFile(obj:["code":code as AnyObject])
        }
        self.present(alert, animated: false)
    }
    
    func reqFile(obj:Dictionary<String, AnyObject>){
        MainFactory.getFiles(obj:obj){ data in
            
            //Mark: all three asynch here should have their ways of detecting already downloaded files
            //Checked
            // TODO: disable cliciking into album if content not fullied downloaded.
            //TODO: downloading progress
            AlbumFactory.updateLocalAlbums(data:data[albumKey])
            ItemsFactory.updateLocalItems(data:data)
            
//            Items.downloadNewItems()
//
            DispatchQueue.main.async{self.collectionView.reloadData()}

        }
    }

    
}

class albumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
}
