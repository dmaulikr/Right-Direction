//
//  ScoreBoardTableCoordinator.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/17/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class ScoreBoardTableCoordinator: NSObject {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var dataSource: ScoreBoardTableDataSource!
  @IBOutlet var delegate: ScoreBoardTableDelegate!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setup() {
    self.registerCells()
  }
  
  func reloadData(data: [ScoreItem]) {
    self.dataSource.data = data;
    self.delegate.data = data;
    self.tableView.reloadData()
  }
  
  func registerCells() {
    let nib = UINib(nibName: String(ScoreBoardTableCell), bundle: nil)
    self.tableView.registerNib(nib, forCellReuseIdentifier: String(ScoreBoardTableCell))
  }
}
