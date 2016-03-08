//
//  DirectionsDataSource.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/8/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

struct DirectionsDataSource: DataSource {
  typealias U = DirectionEntity
  
  let sourceName = "directionsSeed"
  
  func getDataFromFile(fileName: String) -> NSDictionary? {
    var results: NSDictionary?
    
    do {
      let fileUrl: NSURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "json")!
      let data = NSData(contentsOfURL: fileUrl)
      results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
    }
    catch let error as NSError{
      // File will be provided from local json file, so actually no need to show error to user etc.
      print(error.description)
    }
    
    return results
  }
  
  func prepareData() -> [DirectionsDataSource.U] {
    var result: [DirectionEntity] = []
    
    if let source = self.getDataFromFile(sourceName), items = source["data"] as? NSArray {
      for data in items {
        var items = [[DirectionItem]]()
        
        if let directions = data["directions"] as? NSArray {
          for row in directions {
            var rowItem = [DirectionItem]()
            print("row \(row)")
            
            if let columns = row as? NSArray {
              for column in columns {
                print(column)
              }
            }
            
            items.append(rowItem)
          }
        }

        if let successValue = data["success"] as? Int {
          let entity = DirectionEntity(items: items, correctDirection: self.getDirectionTypeByValue(successValue))
          result.append(entity)
        }
      }
    }
    
    return result
  }
  
  func getDirectionTypeByValue(rawValue: Int) -> DirectionsType {
    switch rawValue {
      case 1:
        return .Up
      case 2:
        return .Down
      case 3:
        return .Right
      case 4:
        return .Left
      default:
        return .Empty
    }
  }
}


