//
//  DirectionsManager.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/8/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

class DirectionsManager {
  static let sharedInstance = DirectionsManager()
  var directionsModel = [DirectionEntity]?()
  private init() {}
  var datasource: DirectionsDataSource?
  
  func setup() {
    self.datasource = DirectionsDataSource()
    self.directionsModel = self.datasource?.prepareData() ?? []
  }
  
  func getItem() -> [[DirectionItem]] {
    var items = [[DirectionItem]]()
    var max = self.directionsModel?.count ?? 0
    max = (max > 0) ? max - 1 : 0
    let randomElement = Int.random(0...max)
    
    if let item = self.directionsModel {
      items = item[randomElement].items
    }
    
    return items
  }
}