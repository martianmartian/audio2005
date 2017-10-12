//
//  utils.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

class _u{
    static func makeQueryURL(root:String,queries:Dictionary<String,String>)->String{
        var wtf = root
        var i=0
        for (key,val) in queries{
            switch i{
            case 0: wtf+="?" + String(key)+"=" + String(val)
            default:  wtf+="&" + String(key) + "=" + String(val)
            }
            i+=1
        }
        
        return wtf
    }
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var final=""
        
        func getNewString()->String{
            var randomString = ""
            for _ in 0 ..< length {
                let rand = arc4random_uniform(len)
                var nextChar = letters.character(at: Int(rand))
                randomString += NSString(characters: &nextChar, length: 1) as String
            }
            return randomString
        }
        return final
    }

    static func pluck(data:[Dictionary<String, AnyObject>], key:String)->[String]{
        var arr = [String]()
        for dict in data{
            guard let id = dict[key] as? String else {continue}
            arr.append(id)
        }
        return arr
    }
    
}







