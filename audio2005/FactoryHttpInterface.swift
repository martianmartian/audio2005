
import Foundation
import Alamofire

//ONLY HTTP INTERFACE !!!!!!!!!!!
class FactoryHttpInterface{
    static func getFiles(obj:[String:String],fn:@escaping ([String: AnyObject])->()){
 
        let url = urlRoot+"query_file/"
        
        Alamofire.request(url, parameters: obj).responseJSON { response in
            guard let result = response.result.value as? [String : AnyObject] else {return}
            fn(result)
        }
        
    }
    
    
    static func downloadOne(id:String,setLocalURL:@escaping (_ localURL: String)->()){
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

        let localIdentity = id+".mp3"
        
        let destinationUrl = _u.getLocalURLFrom(localIdentity: localIdentity)
        
        if FileManager.default.fileExists(atPath: destinationUrl.path){
            logmark("find out why it's duplicated? ❓")
            setLocalURL(localIdentity); return
        }
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (destinationUrl, [.removePreviousFile, .createIntermediateDirectories])
//            return (destinationUrl, [])
        }
        logvar("destinationUrl🤞🤞🤞🤞", destinationUrl)
        logvar("remoteUrl 🤞", remoteUrl)
        Alamofire.download(remoteUrl, to: destination).response {response in
            loghere()
            guard response.error == nil else{logerr(response); return}
            guard response.destinationURL != nil else {logmark() ;return}
            //let str = response.destinationURL!.absoluteString
            setLocalURL(localIdentity)
        }
    }
   
    
}




