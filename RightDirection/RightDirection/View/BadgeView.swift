//
//  BadgeView.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/11/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class BadgeView: UIView {
  let badgeViewWidth = 141
  let badgeViewHeight = 160
  let badgeRoundedCorners = 30
  
  @IBOutlet weak var statusImage: UIImageView!
  
  func showBadgeWithType(type: BadgeType) {
    switch type {
      case .Success:
        self.showImageWithAnimation("badgeCorrect")
      case .Fail:
        self.showImageWithAnimation("badgeFail")
    }
  }
  
  func showImageWithAnimation(image: String) {
    self.statusImage.image = UIImage(imageLiteral: image)
    self.hidden = false
    
    UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut], animations: {
      self.alpha = 0.5
      }, completion: { finished in
        if finished {
          self.hideStatus()
        }
    })
  }
  
  func hideStatus() {
    UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut], animations: {
      self.alpha = 0
      
      }, completion: { finished in
        if finished {
          self.hidden = true
        }
    })
  }
  
  func setupBadgeWithResult(result: Bool) {
    if result {
      self.showBadgeWithType(.Success)
    }
    else {
      self.showBadgeWithType(.Fail)
    }
  }
}
