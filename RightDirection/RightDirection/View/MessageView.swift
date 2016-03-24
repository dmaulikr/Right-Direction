//
//  MessageView.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/12/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class MessageView: UIView {
  
  @IBOutlet weak var messageLabel: UILabel!
  let messageViewWidth = 220
  let messageViewHeight = 120
  let messageRoundedCorners = 30
  var completion: (() -> ())?
  var messages = [String]()
  
  // Simple view that shows messages from array with delay, after finish it will 
  // fire completion closure
  func showMessages(input: [String]) {
    var messages = input
    if messages.count > 0 {
      var currentText = ""

      for (index, msg) in messages.enumerate() {
        if index == 0 {
          currentText = msg
          messages.removeFirst()
        }
      }
      
      UIView.animateWithDuration(1, delay: 0, options: [.TransitionNone], animations: { () -> Void in
        self.messageLabel.text = currentText
        self.messageLabel.alpha = 1
        self.messageLabel.alpha = 0
        }, completion: { (complete) -> Void in
          if complete {
            if messages.count > 0 {
              self.showMessages(messages)
            }
            else {
              if let finish = self.completion {
                finish()
              }
            }
          }
      })
    }
  }
  
  // Show simple message inside label
  func showMessage(message: String) {
    self.messageLabel.text = message
    self.messageLabel.alpha = 1
  }
}
