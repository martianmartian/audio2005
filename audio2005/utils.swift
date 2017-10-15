//
//  utils.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

class _u{
    
    
    /**
     setTimeout()
     
     Shorthand method for create a delayed block to be execute on started Thread.
     
     This method returns ``Timer`` instance, so that user may execute the block
     within immediately or keep the reference for further cancelation by calling
     ``Timer.invalidate()``
     
     Example:
     let timer = setTimeout(0.3) {
     // do something
     }
     timer.invalidate()      // cancel it.
     */
    static func setTimeout(_ delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    /**
     setInternval()
     
     Similar to setTimeout() this method will return ``Timer`` instance however, this
     method will execute repeatedly.
     
     Warning using this method with caution, it is recommended that the block to utilise
     this method should call [unowned self] or [weak self] to announce OS that it should not
     hold strong reference to this block.
     
     In addition, ``Timer`` returned should kept as member variable, and call invalidated()
     when the block no longer required. such as deinit, or viewDidDisappear()
     */
    static func setInterval(_ interval:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: interval, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: true)
    }
    
    
    static func getRootDocumentUrl()->URL{
        return  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    static func countMP3atRoot()->Int{
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
            return mp3Files.count
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }

    
    static func getLocalURLFrom(localIdentity:String) -> URL{
        let docDirURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localURL = docDirURL.appendingPathComponent(localIdentity)
        return localURL
    }
    
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







