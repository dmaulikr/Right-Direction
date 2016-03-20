//
//  ScoreBoardTableDataSource.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/17/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class ScoreBoardTableDataSource: NSObject, UITableViewDataSource {
  var data = [ScoreItem]()
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return (self.data.count == 0) ? 0 : 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.data.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cellItem = UITableViewCell()
    if let cell = tableView.dequeueReusableCellWithIdentifier(String(ScoreBoardTableCell), forIndexPath: indexPath) as? ScoreBoardTableCell {
      let item = self.data[indexPath.row]
      cell.setup(item, index: indexPath.row)
      cellItem = cell
    }
    
    return cellItem
  }
}