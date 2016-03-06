//
//  DirectionsView.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/4/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class DirectionsView: UIView {
  
  var datasource = [[DirectionItem]]()
  var directionViews = [[UIView]]()
  
  func setup() {
    var i = 0
    var j = 0
    
    for (row, rowValue) in datasource.enumerate() {
      var tempViews = [UIView]()
      
      for (column, columnValue) in rowValue.enumerate() {
        let lastRow = datasource.count - 1
        let lastColumn = rowValue.count - 1
        let item = self.loadDirectionItem(columnValue)
        tempViews.append(item)
        item.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(item)
        
        //first row, stick to superview
        if(row == 0) {
          if(column == 0) {
            item.pin(self, direction: .Left)
          }
          else if(column == lastColumn) {
            item.pin(self, direction: .Right)
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          else {
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          
          item.pin(self, direction: .Up)
        }
        else if(row == lastRow) {
          if(column == 0) {
            item.pin(self, direction: .Left)
          }
          else if(column == lastColumn) {
            item.pin(self, direction: .Right)
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          else {
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          let topItem = self.directionViews[row - 1][column]
          item.pinWithBottomView(topItem)
          item.equalHeightTo(topItem)
          item.pin(self, direction: .Down)
        }
        else {
          if(column == 0) {
            item.pin(self, direction: .Left)
          }
          else if(column == lastColumn) {
            item.pin(self, direction: .Right)
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          else {
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          let topItem = self.directionViews[row - 1][column]
          item.pinWithBottomView(topItem)
          item.equalHeightTo(topItem)
        }
        
        j = j + 1
      }
      self.directionViews.append(tempViews)
      
      i = i + 1
    }
  }

  func loadDirectionItem(item: DirectionItem) -> DirectionItemView {
    if let view = NSBundle.mainBundle().loadNibNamed("DirectionItemView", owner: self, options: nil)[0] as? DirectionItemView {
      view.setup(item.type)
      return view
    }
    else {
      return DirectionItemView()
    }
  }

}
