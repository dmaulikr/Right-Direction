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
  var directionViews = [[DirectionItemView]]()
  
  // Setup will go through two dimentional array and load views with directions images.
  // Images have equal width and height, and are placed side by side forming simple matrix.
  func setup() {
    var i = 0
    var j = 0
    
    for (row, rowValue) in datasource.enumerate() {
      var tempViews = [DirectionItemView]() //holds temporary views for current row, before they are added to self.directionViews array
      
      for (column, columnValue) in rowValue.enumerate() {
        let lastRow = datasource.count - 1
        let lastColumn = rowValue.count - 1
        
        // Instantiate view for cell that we will be working with
        let item = DirectionItemView.loadDirectionItem(columnValue)
        tempViews.append(item)
        item.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(item) //add cell to main view, then add all constraints that will set view position
        
        /*
          Now we need to add constraints to join all views, sample array with 3x3 element will look like this:
          
          -------
          | |>| |
          -------
          |>|>|>|
          -------
          | |>| |
          -------
        
          Cells with ">" represent images with arrows.
        
          Every cell needs to have connection to each other, the best way to do
          this is to setup leading and top anchor. Last cell from current row will 
          also need trailing anchor, and last cell from last row and column will
          need bottom anchor.
        */
        if(row == 0) {
          if(column == 0) {
            /*
            You are here:
            -------
            |x| | |
            -------
            | | | |
            -------
            | | | |
            -------
            */
            item.pin(self, direction: .Left) //stick left edge to superview
          }
          else if(column == lastColumn) {
            /*
            You are here:
            -------
            | | |x|
            -------
            | | | |
            -------
            | | | |
            -------
            */
            item.pin(self, direction: .Right) //stick right edge to superview
            
            /* 
              Previous element is no longer superview, so we need to stick previous
              cell trailing anchor to current cell leading anchor.
            */
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            // Set equal width and height to match previous element, we
            // want all elements in matrix to have equal size.
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          else {
            /*
            You are here:
            -------
            | |x| |
            -------
            | | | |
            -------
            | | | |
            -------
            */
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          
          // We are in first row, pin all cells to superview top anchor.
          item.pin(self, direction: .Up)
        }
        else if(row == lastRow) {
          if(column == 0) {
            /*
            You are here:
            -------
            | | | |
            -------
            | | | |
            -------
            |x| | |
            -------
            */
            //First column in last row, pin left edge to superview
            item.pin(self, direction: .Left)
          }
          else if(column == lastColumn) {
            /*
            You are here:
            -------
            | | | |
            -------
            | | | |
            -------
            | | |x|
            -------
            */
            //Last column in last row, pin right edge to superview
            item.pin(self, direction: .Right)
            
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          else {
            /*
            You are here:
            -------
            | | | |
            -------
            | | | |
            -------
            | |x| |
            -------
            */
            //Last row, column in the middle
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          // Get cell from previous row and pin top anchor of current item to
          // bottom anchor of top cell.
          let topItem = self.directionViews[row - 1][column]
          item.pinWithBottomView(topItem)
          // We also need to set equal height with previous cell
          item.equalHeightTo(topItem)
          // All cells for last row need to stick bottom to superview.
          item.pin(self, direction: .Down)
        }
        else {
          /*
          You are here:
          -------
          | | | |
          -------
          |x| | |
          -------
          | | | |
          -------
          */
          // First column in the middle row
          if(column == 0) {
            item.pin(self, direction: .Left)
          }
          else if(column == lastColumn) {
            /*
            You are here:
            -------
            | | | |
            -------
            | | |x|
            -------
            | | | |
            -------
            */
            // Last column from row in the middle, pin to right side
            item.pin(self, direction: .Right)
            // Also pin to previous cell trailing anchor to current cell leading anchor
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            // We also need to set equal width and height with previous cell
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          else {
            /*
            You are here:
            -------
            | | | |
            -------
            | |x| |
            -------
            | | | |
            -------
            */
            // Middle column from middle row
            // Pin to previous cell trailing anchor to current cell leading anchor
            let previousItem = tempViews[column - 1]
            previousItem.pinWithRightSideView(item)
            // We also need to set equal width and height with previous cell
            item.equalWidthTo(previousItem)
            item.equalHeightTo(previousItem)
          }
          
          // Get cell from previous row and pin top anchor of current item to
          // bottom anchor of top cell.
          let topItem = self.directionViews[row - 1][column]
          item.pinWithBottomView(topItem)
          // We also need to set equal height with previous top cell
          item.equalHeightTo(topItem)
        }
        
        j = j + 1
      }
      self.directionViews.append(tempViews)
      
      i = i + 1
    }
  }
}
