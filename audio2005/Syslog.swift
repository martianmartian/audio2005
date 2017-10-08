//
//  syslog.swift
//  audio2005
//
//  Created by martian2049 on 10/7/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation

//TODO: disable all in production

func logvar(_ varname:String,_ thevar:Any){
    print("\n------ \(varname)  type: \(type(of: thevar)) ------ : \n",thevar)
}

func logsplit(){
    print("\n\n-------------------------------- awesome line  -----------------------------\n\n")
}

func loghere(_ line:Int = #line, _ function:String = #function, _ file:String = #file){
    print("---------here---------;","Function: \(function), line: \(line), Flie:\(file)")
}

func logerr(_ message:Any, _ line:Int = #line, _ function:String = #function, _ file:String = #file){
    print("\nError found at ===> : \nFlie:\(file)")
    print("Function: \(function), line: \(line)")
    print("\nError message: ")
    print(message)
}


