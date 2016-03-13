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
  let messageViewWidth = 200
  let messageViewHeight = 150
  let messageRoundedCorners = 30
  var completion: (() -> ())?
  var messages = [String]()
  
  // Simple view that shows messages from array with delay, after finish it will 
  // fire completion closure
  func showMessages(messages: [String]) {
    
  }

}
