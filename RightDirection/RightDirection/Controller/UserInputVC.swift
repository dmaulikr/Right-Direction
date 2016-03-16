//
//  UserInputVC.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/16/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

extension UIViewController {
  // Creates alert controller with textfield. Completion closure return what user enters.
  func getFromUser(title: String, completion: (name: String) -> ()) {
    let scoreController = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.Alert)
    scoreController.addTextFieldWithConfigurationHandler { (textfield) -> Void in
      textfield.placeholder = NSLocalizedString("Enter your name", comment: "Enter your name")
      textfield.addTarget(self, action: Selector("alertTextFieldDidChange:"), forControlEvents: .EditingChanged)
    }
    
    let okAction = UIAlertAction(title: NSLocalizedString("Save", comment: "Save"), style: .Default) { (action) -> Void in
      let name: UITextField? = scoreController.textFields?.first
      let result = name?.text ?? ""
      completion(name: result)
    }
    
    okAction.enabled = false
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .Cancel, handler:nil)
    scoreController.addAction(okAction)
    scoreController.addAction(cancelAction)
    self.presentViewController(scoreController, animated: true, completion: nil)
  }
  
  func alertTextFieldDidChange(sender: UITextField) {
    if let alertController = self.presentedViewController as? UIAlertController {
      let name: UITextField? = alertController.textFields?.first
      let okAction = alertController.actions.first
      okAction?.enabled = name?.text?.characters.count >= 1
    }
  }
}