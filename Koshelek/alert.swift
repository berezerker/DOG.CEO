//
//  alert.swift
//  Koshelek
//
//  Created by Berezkin on 30.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func showAlert(_ message: String){
        let dialogMessage = UIAlertController(title: "Error occured", message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Alert dismissed")
         })

        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
