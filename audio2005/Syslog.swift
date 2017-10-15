//
//  syslog.swift
//  audio2005
//
//  Created by martian2049 on 10/7/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

//TODO: disable all in production
func logone( _ args:Any... , active:Bool=true){
    if active{
        for arg: Any in args {
            print(arg, terminator:"")
        }
    }
}

func logvar(_ varname:String, _ thevar:Any, _ line:Int = #line, _ function:String = #function, _ file:String = #file,active:Bool=true){
    if active{
        print("\n---------- \(varname)  type: \(type(of: thevar)) ---------- : ")
        print("Function: \(function), line: \(line), Flie:\(file)")
        print(thevar,"\n")
        
    }
}

func logsplit(_ line:Int = #line, _ function:String = #function, _ file:String = #file,active:Bool=true){
    if active{
        print("\n\n-------------------------------- awesome line  -----------------------------\n\n","Function: \(function), line: \(line), Flie:\(file)")
    }
}

func loghere(_ line:Int = #line, _ function:String = #function, _ file:String = #file,active:Bool=true){
    if active{
        print("\n---✅✅✅------here---------;","Function: \(function), line: \(line), Flie:\(file)","\n\n")
    }
}

func logmark(_ mark:String="Potential Error here" ,_ line:Int = #line, _ function:String = #function, _ file:String = #file,active:Bool=true){
    if active{
        print("\n-----\(mark)----")
        print("Function: \(function), line: \(line), Flie:\(file)\n")
    }
}

func logerr(_ message:Any?, _ line:Int = #line, _ function:String = #function, _ file:String = #file,active:Bool=true){
    if active{
        print("\nError found at 👺👺👺👺👺👺 ===> : \nFlie:\(file)")
        print("Function: \(function), line: \(line)")
        print("\nError message: ")
        print(message as Any)
    }
}


