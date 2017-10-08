

import UIKit

class IViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{

    var Albums : [Dictionary<String, AnyObject>]{
        get{return AlbumFactory.getLocalAlbums()}
    }
    
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func removeAll(_ sender: UIButton) {
        
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
        let CellTap:UITapGestureRecognizer
        if indexPath.row == 0{
            //Mark: the first addition button
            CellTap = UITapGestureRecognizer(target:self,action:#selector(IViewController.prepReq))
        }else{
            //Mark: albums
            CellTap = UITapGestureRecognizer(target:self,action:#selector(IViewController.goToView2))
            albumCell.tag = indexPath.row-1
        }
        albumCell.addGestureRecognizer(CellTap)
        return albumCell
    }
    @objc func goToView2(_ gesture:AnyObject){ //print("go to second view here")
        let v = gesture.view!
        let tag = v.tag
        logvar("tag", tag)
//        print("Going to album: \(Albums.content[tag]["albumid"] ?? "Something wrong" as AnyObject)")
//
//        MP3.viewingAlbum = Albums.content[tag]
//        self.performSegue(withIdentifier: "toSecond", sender: self)
    }
    @objc func prepReq(){
        loghere()
//        let alert = UIAlertController(title: "For Sync", message: "Enter yoru code", preferredStyle: .alert)
//        alert.addTextField { (textField) in textField.text = ""}
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            //Mark: if valid code, request files from server
//            guard let code = textField?.text else {print("invalide code");return}
//            self.reqFile(obj:["code":code as AnyObject])
//        }))
//        self.present(alert, animated: false, completion: nil)
    }
    
//    func reqFile(obj:Dictionary<String, AnyObject>){
//
//        HttpReq.getFile(obj:obj){data in
//
//            //Mark: all three asynch here should have their ways of detecting already downloaded files
//            //Checked
//            // TODO: disable cliciking into album if content not fullied downloaded.
//            //TODO: downloading progress
//            Albums.newAlbumsIntoDB(data:data["albums"] as! [Dictionary<String, AnyObject>])
//            Items.newItemsIntoDB(data:data["items"] as! [Dictionary<String, AnyObject>])
//
//            Albums.content = Models.db.value(forKey: Albums.entity) as! [Dictionary<String, AnyObject>]
//            Items.content = Models.db.value(forKey: Items.entity) as! [Dictionary<String, AnyObject>]
//
//            Items.downloadNewItems()
//
//            DispatchQueue.main.async{self.collectionView.reloadData()}
//
//        }
//    }

    
}

class albumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
}
