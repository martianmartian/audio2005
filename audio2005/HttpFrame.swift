

import Foundation

class HTTP{
    
    static func req(config:[String:AnyObject],fn:@escaping([String: AnyObject])->()){

        let request = HTTP.prepReq(config:config as [String : AnyObject])
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,res,err)-> Void in
            if err != nil{print("returned nil from HttpReq.getFile server request");return}
            do {
                guard let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else {
                    logmark();return}
                fn(result)
            }catch{print("Error -> \(error)")}
            
        }).resume()
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
