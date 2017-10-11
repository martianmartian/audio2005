

import Foundation

class HTTP{
    
    static func req(config:[String:AnyObject],fn:@escaping([String: AnyObject])->()){

        let request = HTTP.prepReq(config:config as [String : AnyObject])
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,res,err)-> Void in
            if err != nil {print("returned nil from HttpReq.getFile server request");return}
            do {
                guard let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else {
                    logmark();return}
                fn(result)
            }catch{print("Error -> \(error)")}

        }).resume()
    }
    
    static func getMP3(id:String,setLocalURL:@escaping (_ localURL: URL)->()){
        
        let url = urlRoot + "get_mp3?id=" + id
        let reqUrl = URL(string:url)!
        
        let docDirURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localDirURL = docDirURL.appendingPathComponent(id+".mp3")
        
        if FileManager.default.fileExists(atPath: localDirURL.path){
            print("MP3 file download duplicated------,reseting anyways");
            setLocalURL(localDirURL)
            return
        }
        
        URLSession.shared.downloadTask(with: reqUrl, completionHandler:{(tempLocalUrl,response,error) -> Void in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            guard statusCode==200, let tempLocalUrl = tempLocalUrl, error == nil else{
                logvar("statusCode", statusCode as Any)
                logerr(error as Any)
                return
            }
            logvar("tempLocalUrl", tempLocalUrl)
            do {
                try FileManager.default.moveItem(at: tempLocalUrl, to: localDirURL)
                setLocalURL(localDirURL)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
    }

    
}

extension HTTP{
    
    static func prepReq(config:[String:AnyObject])->URLRequest{
        var url = URLComponents(string: config["root"] as! String)
        let them = (config["queries"] as? [String:AnyObject])!
        url?.queryItems=[]
        for (key,val) in them{
            url?.queryItems?.append(URLQueryItem(name:key,value:val as? String))
        }
        var request = URLRequest(url:(url?.url)!)
        request.httpMethod = config["method"] as? String
        return request
        
        //let config=[
        //    "root":"http://localhost:8080/test",
        //    "method":"GET",
        //    "params":obj
        //    ] as [String : AnyObject]
        //let req = URL.config(config:config as [String : AnyObject])
    }
}
