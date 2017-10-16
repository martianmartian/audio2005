

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
        //logvar("viewItems", viewItems)
    }
    
    func swichColor(_ t:AnyObject?)->UIColor{
        guard let type = t as? String else {return UIColor.black}
        switch type {
        case "new":
            return UIColor.cyan
        default:
            return UIColor.black
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewItems.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "itemCell")
        let item = viewItems[indexPath.row]
        cell.textLabel?.text = item["itemName"] as? String
        cell.textLabel?.textColor = swichColor(item["newOrOld"])
        cell.isUserInteractionEnabled=true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewItems[indexPath.row]

        if (item["newOrOld"] as? String) == "new" {
            logmark("not permitted 👾");
            AlbumFactory.downloadAll_r()
            return
        }// start downloading?
        MP3.outlet = item
        self.performSegue(withIdentifier: "twoTothree", sender: self)
    }
    
    
}




