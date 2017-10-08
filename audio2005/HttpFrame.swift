

import Foundation

class HTTP{
    
    static func req(config:[String:AnyObject],fn:@escaping(AnyObject)->()){

        let request = HTTP.makeReq(config:config as [String : AnyObject])
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,res,err)-> Void in
            //print(data!)
            if err != nil{print("returned nil from HttpReq.getFile server request");return}
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                fn(result as AnyObject)
            }catch{print("Error -> \(error)")}
            
        }).resume()
    }
    
}

extension HTTP{
    
    static func makeReq(config:[String:AnyObject])->URLRequest{
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
