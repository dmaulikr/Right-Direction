//
//  SwipeGestureExtension.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/10/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

extension UISwipeGestureRecognizerDirection {
  func translateToDirection() -> DirectionsType {
    switch self {
      case UISwipeGestureRecognizerDirection.Right:
        return .Right
      case UISwipeGestureRecognizerDirection.Left:
        return .Left
      case UISwipeGestureRecognizerDirection.Up:
        return .Up
      case UISwipeGestureRecognizerDirection.Down:
        return .Down
      default:
        return .Empty
    }
  }
}