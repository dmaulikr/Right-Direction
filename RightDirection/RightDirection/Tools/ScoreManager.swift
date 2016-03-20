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
  let saveKey = "userScore"
  
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
  
  // Simple save user score object to user defaults.
  func saveScoreForUser(name: String) {
    var scores = self.getScores()
    let newScore = ScoreItem(name: name, scoreValue: self.userScore)
    scores.append(newScore)
    let data = NSKeyedArchiver.archivedDataWithRootObject(scores)
    NSUserDefaults.standardUserDefaults().setObject(data, forKey: self.saveKey)
  }
  
  func getScores() -> [ScoreItem] {
    var results = [ScoreItem]()
    
    if let items = NSUserDefaults.standardUserDefaults().objectForKey(self.saveKey) as? NSData,
            data = NSKeyedUnarchiver.unarchiveObjectWithData(items) as? [ScoreItem] {
      results = data.sort({ $0.scoreValue > $1.scoreValue })
    }
    
    return results
  }
  
  
  
}