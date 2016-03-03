//
//  GameTabViewController.swift
//  RightDirection
//
//  Created by Mike Mikina on 2/28/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit
import SwiftHEXColors

class GameTabViewController: UIViewController {

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var controlsView: UIView!
  @IBOutlet weak var pointsLabel: UILabel!
  @IBOutlet weak var gameTabVC: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.closeButton.setTitle(NSLocalizedString("Close", comment: "Close"), forState: .Normal)
    setupView()
  }
  
  func setupView() {
    if let controls = self.controlsView {
      controls.backgroundColor = UIColor(hexString: kMainColor)
    }
    if let points = self.pointsLabel {
      points.textColor = UIColor(hexString: kMainTextColor)
      points.text = NSLocalizedString("Points: ", comment: "Points: ") + "0"
    }
    if let close = self.closeButton {
      close.tintColor = UIColor(hexString: kMainTextColor)
    }
    
    let vc = GameBoardViewController()
    self.addChildViewController(vc)
    if let gameTab = self.gameTabVC {
      gameTab.addSubview(vc.view)
    }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    return UIStatusBarAnimation.Slide
  }
  
  @IBAction func closeAction(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
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
