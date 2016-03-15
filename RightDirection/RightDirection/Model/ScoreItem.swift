//
//  ScoreItem.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/15/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

class ScoreItem: NSObject, NSCoding {
  var name: String
  var scoreValue: Int
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("name") as! String
    scoreValue = aDecoder.decodeObjectForKey("scoreValue") as! Int
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(scoreValue, forKey: "scoreValue")
  }
  
  init(name: String, scoreValue: Int) {
    self.name = name
    self.scoreValue = scoreValue
  }
}