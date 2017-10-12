//
//  MainFactory.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation
import Alamofire

class FactoryHttpInterface{
    static func getFiles(obj:[String:String],fn:@escaping ([String: AnyObject])->()){
 
        let url = urlRoot+"query_file/"
        
        Alamofire.request(url, parameters: obj).responseJSON { response in
            guard let result = response.result.value as? [String : AnyObject] else {return}
            fn(result)
        }
        
    }
    
    static func removeEverything(){
        db.removeObject(forKey:albumKey)
        
    }
    static func removeAlbum(id:String){
        
    }
    static func removeOne(item:Dictionary<String,AnyObject>){
        
    }
    
    static func downloadOne(id:String,setLocalURL:@escaping (_ localURL: URL)->()){
        /* pseudo code: download single mp3 file.
         remote url + id
         local destinationUrl
             ?? check if file at destination already exist??
                 if it does, set it, and return
                     //MP3 file download duplicated------,reseting anyways
         download request
             download func's callback:
             logvar status code
             logerr if any
             move file to destination? taken care of by alamofire
             callback setLocalURL(destinationUrl)
                 store destinationUrl to item
                 set item newOrOld to old.
         */
        
        let remoteUrl = _u.makeQueryURL(root: urlRoot + "get_mp3", queries: ["id":id])

        let docDirURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = docDirURL.appendingPathComponent(id+".mp3")
        guard !FileManager.default.fileExists(atPath: destinationUrl.path) else{
            logmark("find out why it's duplicated? ")
            setLocalURL(destinationUrl); return
        }
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (destinationUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(remoteUrl, to: destination).response { response in
            
            guard response.error == nil else{logerr(response); return}
            guard response.destinationURL != nil else {logmark() ;return}
//            let str = response.destinationURL!.absoluteString
            setLocalURL(response.destinationURL!)
        }
    }
   
    
    
}
