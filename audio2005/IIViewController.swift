

import UIKit

class IIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var viewAlbumId : String{return AlbumFactory.viewAlbumId}
    var viewItems : [Dictionary<String, AnyObject>]{
        return ItemsFactory.getLocalItemsOf(albumId: viewAlbumId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.alwaysBounceVertical = false
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewItems.count }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! itemCell
//        cell.itemCell.text = MP3.viewingItems[indexPath.row]["itemName"] as? String
//        cell.tag = indexPath.row
//        //print(cell.tag)
//        cell.isUserInteractionEnabled=true
//        let cellTap:UITapGestureRecognizer
//        cellTap = UITapGestureRecognizer(target:self,action:#selector(SecondViewController.selectedItem))
//        cell.addGestureRecognizer(cellTap)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("current item is at: \(MP3.viewingItems[indexPath.row]["itemId"] ?? "Something wrong" as AnyObject)")
    }
    
    
}


class itemCell: UITableViewCell {
    
    
    
}
