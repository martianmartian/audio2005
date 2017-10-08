//
//  utils.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

class _u{
    
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

    static func pluck(data:[Any], key:String)->[String]{
        var arr = [String]()
        if data.count>0{
            for al in data{
                let al = al as AnyObject
                arr.append(al.value(forKey:key) as! String)
            }
        }
        return arr
    }
    
}







