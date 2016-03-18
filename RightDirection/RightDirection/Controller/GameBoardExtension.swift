//
//  GameBoardExtension.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/15/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

extension GameBoardViewController {
  func showFinalMessage(message: String) {
    let messageView = self.prepareMessageView()
    messageView?.showMessage(message)
  }
  
  func showHelloMessages(messages: [String]) {
    let messageView = self.prepareMessageView()
    messageView?.showMessages(messages)
    messageView?.completion = {
      messageView?.removeFromSuperview()
      self.startGame()
    }
  }
  
  private func prepareMessageView() -> MessageView? {
    if let mView = NSBundle.mainBundle().loadNibNamed("MessageView", owner: self, options: nil)[0] as? MessageView {
      self.view.addSubview(mView)
      mView.translatesAutoresizingMaskIntoConstraints = false
      mView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
      mView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
      mView.widthAnchor.constraintEqualToConstant(CGFloat(mView.messageViewWidth)).active = true
      mView.heightAnchor.constraintEqualToConstant(CGFloat(mView.messageViewHeight)).active = true
      mView.layer.cornerRadius = CGFloat(mView.messageRoundedCorners)
      
      return mView
    }
    
    return nil
  }
}