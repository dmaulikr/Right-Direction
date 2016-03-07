//
//  DirectionItem.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/4/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class DirectionItemView: UIView {

  @IBOutlet weak var directionImage: UIImageView!
    
  func setup(type: DirectionsType) {
    if let item = self.directionImage {
      if(type != .Empty) {
        item.image = self.getImageByType(type)
      }
    }
  }

  func getImageByType(type: DirectionsType) -> UIImage {
    let imageName: String
    
    switch(type) {
      case .Up:
        imageName = "directionUp"
      case .Down:
        imageName = "directionDown"
      case .Left:
        imageName = "directionLeft"
      case .Right:
        imageName = "directionRight"
      case .Empty:
        imageName = ""
    }
    
    return UIImage(named: imageName)!
  }
  
  class func loadDirectionItem(item: DirectionItem) -> DirectionItemView {
    if let view = NSBundle.mainBundle().loadNibNamed("DirectionItemView", owner: self, options: nil)[0] as? DirectionItemView {
      view.setup(item.type)
      return view
    }
    else {
      return DirectionItemView()
    }
  }
}
