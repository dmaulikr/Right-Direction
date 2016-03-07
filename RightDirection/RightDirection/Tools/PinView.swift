//
//  PinView.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/6/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func pin(to: UIView, direction: DirectionsType) {
    switch direction {
      case .Up:
        self.topAnchor.constraintEqualToAnchor(to.topAnchor).active = true
      case .Down:
        self.bottomAnchor.constraintEqualToAnchor(to.bottomAnchor).active = true
      case .Left:
        self.leadingAnchor.constraintEqualToAnchor(to.leadingAnchor).active = true
      case .Right:
        self.trailingAnchor.constraintEqualToAnchor(to.trailingAnchor).active = true
      default:
        break;
    }
  }
  
  func pinWithRightSideView(view: UIView) {
    self.trailingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
  }
  
  func pinWithBottomView(view: UIView) {
    self.topAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
  }
  
  func equalWidthTo(view: UIView) {
    self.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 1).active = true
  }
  
  func equalHeightTo(view: UIView) {
    self.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 1).active = true
  }
}