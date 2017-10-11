//
//  MainFactory.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

class FactoryHttpInterface{
    static func getFiles(obj:[String:AnyObject],fn:@escaping ([String: AnyObject])->()){
        
        let config=[
            "root": urlRoot + "query_file",
            "method":"GET",
            "queries":obj
            ] as [String : AnyObject]
        
        HTTP.req(config:config){result in
            logvar("result", result)
            logvar("type(of: result)", type(of: result))
            fn(result)
        }
    }
    
    static func removeEverything(){
        db.removeObject(forKey:albumKey)
    }
    
    static func downloadOne(id:String){
        let config = [
            "root":urlRoot + "get_mp3",
            "method":"GET",
            "queries":["id":id]
            ] as [String : AnyObject]
        print(config)

        
    }
    
}
