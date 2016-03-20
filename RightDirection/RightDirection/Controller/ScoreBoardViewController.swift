//
//  ScoreBoardViewController.swift
//  RightDirection
//
//  Created by Mike Mikina on 2/27/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class ScoreBoardViewController: RootViewController {

  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var tableViewCoordinator: ScoreBoardTableCoordinator!
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = NSLocalizedString("Scoreboard", comment: "Scoreboard")
    self.infoLabel.text = NSLocalizedString("No scores yet, play the game first!", comment: "No scores yet, play the game first!")
    self.tableViewCoordinator.setup()
  }

  func reloadData() {
    let scoreManager = ScoreManager()
    self.tableViewCoordinator.reloadData(scoreManager.getScores())
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    self.reloadData()
  }
  
}
