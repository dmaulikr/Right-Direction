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
    
  func setup(imageName: String) {
    if let item = self.directionImage {
      item.image = UIImage(named: imageName)
    }
  }
}
