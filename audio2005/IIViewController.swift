

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
        logvar("viewItems", viewItems)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewItems.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "itemCell")
        cell.textLabel?.text = viewItems[indexPath.row]["itemName"] as? String
        cell.isUserInteractionEnabled=true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexPath.row
//        MP3.selectedItem(tappedItemIndex:tappedItemIndex)
//        // always to switch view the third
//        self.performSegue(withIdentifier: "toThird", sender: self)
    }
    
    
}




