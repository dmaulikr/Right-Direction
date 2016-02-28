//
//  GameDashboardViewController.swift
//  RightDirection
//
//  Created by Mike Mikina on 2/27/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class GameDashboardViewController: RootViewController {

  @IBOutlet weak var startButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.title = NSLocalizedString("Dashboard", comment: "Dashboard")
    self.startButton.setTitle(NSLocalizedString("Start game", comment: "Start game"), forState: .Normal)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  @IBAction func startAction(sender: AnyObject) {
    let game = GameTabViewController()
    self.presentViewController(game, animated: true, completion: nil)
  }
  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
