//
//  Extensions.swift
//  audio2005
//
//  Created by martian2049 on 10/7/17.
//  Copyright © 2017 martian2049. All rights reserved.
//



import Foundation

extension Array{
    func prevIndex(_ index: Int) -> Int?{
        if self.count==0 {return nil}
        var prevIndex : Int
        if index==0 {prevIndex=0}
        else{prevIndex = index-1}
        
        return prevIndex
    }
    func nextIndex(_ index: Int) -> Int?{
        if self.count==0 {return nil}
        var nextIndex : Int
        if index==self.count-1 {nextIndex = self.count-1}
        else{nextIndex = index+1}
        
        return nextIndex
    }
}

extension URL {
    static func help(_ which:String?=nil){
        if which == "extension"{
            print("USE: ['subscript']")
            print("let url = URL(string: 'http://some-website.com/documents/127/?referrer=147&mode=open')!")
            print("let referrer = url['referrer'] ")
            print("let mode     = url['mode']    ")
            
            print("USE: .valueOf")
            print("let newURL = URL(string: 'http://mysite3994.com?test1=blah&test2=blahblah')!")
            print("newURL.valueOf('test1')")
            print("newURL.valueOf('test2')")
            
            print("USE:URL.getQueryUrlParam")
            print("let test1 = getQueryStringParameter(url, param: 'test1')")
        }else{
            print("let str='http://localhost:8080/'")
            print("var xurl = URL.init(string: str)")
            print("print(xurl)")
            print("print(xurl!)")
            print("let str1='http://localhost:8080/what?dog=bla&cat=meow'")
            print("var qurl = URL.init(string: str1)")
            print("print(qurl?.query)")
            print("print(qurl?.port)")
            print("print(qurl?.path)")
            print("print(qurl?.baseURL)")
            print("print(qurl?.host)")
            print("print(qurl?.pathComponents)")
            print("let p1='what'")
            print("let q1='dog'")
            print("var surl = URL.init(string:'http://localhost:8080/\\(p1)?q1=\\(q1)')")
        }
    }
    subscript(queryParam:String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
    func valueOf(queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
    static func getQueryUrlParam(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
}

extension URLRequest{
    
    static func makeQueryURL(root:String,queries:[String:String])->URL{
        var wtf = root
        for (key,val) in queries{
            let appendie = "?" + String(key)+"="+String(val)
            wtf+=appendie
        }
        return URL(string:wtf)!
    }
    
    static func config(config:[String:AnyObject])->URLRequest{
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

extension URLComponents{
    static func help(){
        print("var url=URLComponents()")
        print("or...: var url = URLComponents(string: 'http://localhost:8080/test')")
        print("url.scheme = 'http'")
        print("url.host = 'localhost'")
        print("url.port = 8080")
        print("url.path = '/dog'")
        print("url.queryItems=[URLQueryItem(name:'test',value:'data'),URLQueryItem(name:'foo',value:'bar')]")
        print("print(url.string!)")
        print("print(url.query!)")
        print("print(type(of: url.queryItems!))")
        print("url.queryItems?.first(where: { $0.name == 'foo' })?.value")
        print("print(url.queryItems!.first(where: { $0.name == 'foo' })!)")
    }
}

