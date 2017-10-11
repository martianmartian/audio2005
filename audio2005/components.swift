//
//  components.swift
//  audio2005
//
//  Created by martian2049 on 10/8/17.
//  Copyright © 2017 martian2049. All rights reserved.
//

import Foundation
import UIKit

class _c{
    
    static func userinput(title:String,message:String,completion:@escaping (_ input :String)->())->UIAlertController{
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
            textField.accessibilityIdentifier="code"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            guard let code = textField?.text else {print("invalide code");return }
            //do something here to notify user that the code is invalide, and promote to re-enter
            completion(code)
        }))
        return alert
    }

}
