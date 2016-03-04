//
//  DirectionsView.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/4/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class DirectionsView: UIView {
  
  func setup() {          
    if let item = NSBundle.mainBundle().loadNibNamed("DirectionItemView", owner: self, options: nil)[0] as? DirectionItemView {
      item.setup("arrowTest")
      self.addSubview(item)
      item.translatesAutoresizingMaskIntoConstraints = false
      item.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
      
//      item.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
      item.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
      item.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
      if let item2 = NSBundle.mainBundle().loadNibNamed("DirectionItemView", owner: self, options: nil)[0] as? DirectionItemView {
        item2.setup("first")
        self.addSubview(item2)
        item2.translatesAutoresizingMaskIntoConstraints = false

        item2.leadingAnchor.constraintEqualToAnchor(item.trailingAnchor).active = true
        item.trailingAnchor.constraintEqualToAnchor(item2.leadingAnchor).active = true
        item2.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        item2.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        item2.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        item2.widthAnchor.constraintEqualToAnchor(item.widthAnchor, multiplier: 1).active = true
      }
      
    }
  }
}
