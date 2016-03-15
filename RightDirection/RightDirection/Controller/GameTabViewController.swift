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
  @IBOutlet weak var timeLabel: UILabel!
  
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
    if let time = self.timeLabel {
      time.textColor = UIColor(hexString: kMainTextColor)
      time.text = NSLocalizedString("Time: ", comment: "Time: ") + "01:00"
    }
    if let close = self.closeButton {
      close.tintColor = UIColor(hexString: kMainTextColor)
    }
    
    let vc = GameBoardViewController()
    self.addChildViewController(vc)
    
    // Closure for points update, called inside GameBoardViewController when 
    // user swipes in correct direction.
    vc.updatePoints = { pointsValue in
      if let points = self.pointsLabel {
        points.text = NSLocalizedString("Points: ", comment: "Points: ") + String(pointsValue)
      }
    }
    
    // Closure for time update, called inside GameBoardViewController on every second, and after time ends.
    vc.updateTime = { timeValue in
      if let time = self.timeLabel {
        time.text = NSLocalizedString("Time: ", comment: "Time: ") + timeValue.showAsTime()
      }
    }
    
    if let gameTab = self.gameTabVC {
      gameTab.addSubview(vc.view)
      vc.view.translatesAutoresizingMaskIntoConstraints = false
      vc.view.pin(gameTab, direction: .Left)
      vc.view.pin(gameTab, direction: .Right)
      vc.view.pin(gameTab, direction: .Up)
      vc.view.pin(gameTab, direction: .Down)
    }
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
}
