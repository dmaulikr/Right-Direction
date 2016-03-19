//
//  ScoreBoardTableDelegate.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/17/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class ScoreBoardTableDelegate: UIControl, UITableViewDelegate {
  var data = [ScoreItem]()
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}
