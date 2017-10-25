
import Foundation
import MediaPlayer

class AlbumFactory{
    
    static var viewAlbumId = String()

    static func getMediaAlbums() -> Array<MPMediaItemCollection>{
        loghere()
        let query = MPMediaQuery.playlists()
        guard let albums = query.collections else {return Array<MPMediaItemCollection>()}
        return albums
    }
    
    
}












