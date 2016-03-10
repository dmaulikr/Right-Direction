//
//  ScoreManager.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/10/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

class ScoreManager {
  var userScore = 0
  
  // We calculate score based on result that will come from recognizer.
  // If result is true, that means user has swiped in right direction and 
  // he earn points, otherwise we subtract some points from his score.
  func calculateScore(result: Bool) {
    if result {
      self.userScore += kPointsPositive
    }
    else {
      self.userScore -= kPointsNegative
    }
  }
}