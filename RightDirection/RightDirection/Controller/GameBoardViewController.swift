//
//  GameBoardViewController.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/3/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

  @IBOutlet weak var directionsViewHeight: NSLayoutConstraint!
  @IBOutlet weak var directionsViewWidth: NSLayoutConstraint!
  @IBOutlet weak var directionsViewAxisX: NSLayoutConstraint!
  @IBOutlet weak var directionsViewAxisY: NSLayoutConstraint!
  
  @IBOutlet weak var directionsView: DirectionsView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("didload width: \(self.view.frame.size.width) height: \(self.view.frame.size.height)")

    self.setupView()
  }
    
  override func viewWillAppear(animated: Bool) {
    print("willappear width: \(self.view.frame.size.width) height: \(self.view.frame.size.height)")
  }
  
  override func viewDidAppear(animated: Bool) {
    print("didappear width: \(self.view.frame.size.width) height: \(self.view.frame.size.height)")
  }
  
  func setupView() {
    for direction in [.Right, .Left, .Up, .Down] as [UISwipeGestureRecognizerDirection] {
      self.addSwipeRecognizerForDirection(direction)
    }
    
    if let directions = NSBundle.mainBundle().loadNibNamed("DirectionsView", owner: self, options: nil)[0] as? DirectionsView {
      directions.datasource = self.setupMockData()
      directions.setup()
      self.directionsView.addSubview(directions)
      directions.translatesAutoresizingMaskIntoConstraints = false
      directions.leadingAnchor.constraintEqualToAnchor(self.directionsView.leadingAnchor).active = true
      directions.trailingAnchor.constraintEqualToAnchor(self.directionsView.trailingAnchor).active = true
      directions.topAnchor.constraintEqualToAnchor(self.directionsView.topAnchor).active = true
      directions.bottomAnchor.constraintEqualToAnchor(self.directionsView.bottomAnchor).active = true
    }
  }
  
  func setupMockData() -> [[DirectionItem]] {
    var items = [[DirectionItem]]()
    
    let itemEmpty = DirectionItem(type: .Empty)
    let itemUp = DirectionItem(type: .Up)
    let itemDown = DirectionItem(type: .Down)
    
    var row = [DirectionItem]()
    row.append(itemEmpty)
    row.append(itemUp)
    row.append(itemEmpty)
    items.append(row)
    
    row = [DirectionItem]()
    row.append(itemUp)
    row.append(itemDown)
    row.append(itemUp)
    items.append(row)
    
    row = [DirectionItem]()
    row.append(itemEmpty)
    row.append(itemUp)
    row.append(itemEmpty)
    items.append(row)
    
    return items
  }
  
  func addSwipeRecognizerForDirection(direction: UISwipeGestureRecognizerDirection) {
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
    swipeGesture.direction = direction //it's also possible to pass whole array here, but apparently in that case only left and right swipe works (Xcode 7.2)
    self.view.addGestureRecognizer(swipeGesture)
  }
  
  func handleSwipe(swipe: UISwipeGestureRecognizer) {
    print("swipe: \(swipe.direction)")
    let randomSquareSize = Int.random(50...250)
    
    let maxX = Int(self.view.frame.size.width) - randomSquareSize
    let maxY = Int(self.view.frame.size.height - 44) - randomSquareSize
    
    let randomX = Int.random(1...maxX)
    let randomY = Int.random(1...maxY)
    
    self.directionsViewAxisX.constant = CGFloat(randomX)
    self.directionsViewAxisY.constant = CGFloat(randomY)
    
    self.directionsViewWidth.constant = CGFloat(randomSquareSize)
    self.directionsViewHeight.constant = CGFloat(randomSquareSize)
    
//    self.view.layoutIfNeeded()
//    self.view.layoutSubviews()
    
        print("width: \(self.view.frame.size.width) height: \(self.view.frame.size.height)")
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
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
