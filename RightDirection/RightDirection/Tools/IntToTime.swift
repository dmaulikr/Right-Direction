//
//  IntToTime.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/15/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

extension Int {
  // Simple function to format time in seconds to looks like this: 59.showAsTime() -> 00:59
  // Doesn't work with hours.
  func showAsTime() -> String {
    let minutes = self / 60
    let seconds = Double(self) - Double(minutes) * 60
    return String(format: "%02i:%02i", minutes, Int(seconds))
  }
}