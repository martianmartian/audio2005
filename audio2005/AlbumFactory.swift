
import Foundation
import MediaPlayer

class AlbumFactory{
    
    static var viewAlbumId = String()

    static func getMediaAlbums() -> Array<MPMediaItemCollection>{
        let query = MPMediaQuery.playlists()
        guard let albums = query.collections else {return Array<MPMediaItemCollection>()}
        
        var result = Array<MPMediaItemCollection>()
        for album in albums{
            let name = album.value(forProperty: MPMediaPlaylistPropertyName) as! String
            if name != "Purchased"{
                result.append(album)
            }
        }
        
        return result
    }
    
    
}












