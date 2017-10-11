//
//  syslog.swift
//  audio2005
//
//  Created by martian2049 on 10/7/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

//TODO: disable all in production

func logvar(_ varname:String, _ thevar:Any, _ line:Int = #line, _ function:String = #function, _ file:String = #file){
    print("\n\nFunction: \(function), line: \(line), Flie:\(file)")
    print("---------- \(varname)  type: \(type(of: thevar)) ---------- : ")
    print(thevar,"\n")
}

func logsplit(_ line:Int = #line, _ function:String = #function, _ file:String = #file){
    
    print("\n\n-------------------------------- awesome line  -----------------------------\n\n","Function: \(function), line: \(line), Flie:\(file)")
}

func loghere(_ line:Int = #line, _ function:String = #function, _ file:String = #file){
    print("\n\n---------here---------;","Function: \(function), line: \(line), Flie:\(file)","\n\n")
}

func logmark(mark:String="Potential Error here" ,_ line:Int = #line, _ function:String = #function, _ file:String = #file){
    print("\n\nFunction: \(function), line: \(line), Flie:\(file)")
    print("-----\(mark)----\n")
}

func logerr(_ message:Any, _ line:Int = #line, _ function:String = #function, _ file:String = #file){
    print("\nError found at ===> : \nFlie:\(file)")
    print("Function: \(function), line: \(line)")
    print("\nError message: ")
    print(message)
}


