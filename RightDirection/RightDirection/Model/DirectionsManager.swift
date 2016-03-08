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
  let directionsModel = [DirectionEntity]()
  private init() {}
  var datasource: DirectionsDataSource?
  
  func setup() {
    self.datasource = DirectionsDataSource()
    self.datasource?.prepareData()
    
  }
}