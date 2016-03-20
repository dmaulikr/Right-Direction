//
//  ScoreBoardTableCell.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/17/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class ScoreBoardTableCell: UITableViewCell {

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var score: UILabel!
  
  func setup(data: ScoreItem, index: Int) {
    let position = String(index + 1)
    self.name.text = position + ". " + data.name
    self.score.text = String(data.scoreValue) + NSLocalizedString(" points", comment: " points")
  }
}
