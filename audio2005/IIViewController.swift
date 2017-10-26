

import UIKit

class IIVCData{
    static var viewAlbumIndex = 0
}

class IIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var viewItems = ItemsFactory.getItemsOf(albumIndex: IIVCData.viewAlbumIndex)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.alwaysBounceVertical = false
        //logvar("viewItems", viewItems)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewItems.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "itemCell")
        let item = viewItems[indexPath.row]
        cell.textLabel?.text = item.title
        cell.isUserInteractionEnabled=true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        MP3.setPlay(albumI: IIVCData.viewAlbumIndex, itemI: indexPath.row)
        
        self.performSegue(withIdentifier: "twoTothree", sender: self)
    }
    
    
}




