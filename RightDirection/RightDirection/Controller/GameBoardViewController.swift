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
  var scoreManager: ScoreManager?
  var updatePoints: ((points: Int) -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setup()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.setupDirections()
    self.setRandomPosition()
  }
    
  func setup() {
    self.scoreManager = ScoreManager()
    self.setupView()
  }
  
  func setupView() {
    for direction in [.Right, .Left, .Up, .Down] as [UISwipeGestureRecognizerDirection] {
      self.addSwipeRecognizerForDirection(direction)
    }
  }
  
  func setupDirections() {
    self.directionsView.cleanUp()
    
    if let directions = NSBundle.mainBundle().loadNibNamed("DirectionsView", owner: self, options: nil)[0] as? DirectionsView {
      directions.datasource = DirectionsManager.sharedInstance.getItem()
      directions.setup()
      self.directionsView.addSubview(directions)
      directions.translatesAutoresizingMaskIntoConstraints = false
      directions.leadingAnchor.constraintEqualToAnchor(self.directionsView.leadingAnchor).active = true
      directions.trailingAnchor.constraintEqualToAnchor(self.directionsView.trailingAnchor).active = true
      directions.topAnchor.constraintEqualToAnchor(self.directionsView.topAnchor).active = true
      directions.bottomAnchor.constraintEqualToAnchor(self.directionsView.bottomAnchor).active = true
    }
  }
  
  func setRandomPosition() {
    let randomSquareSize = Int.random(200...250)
    
    let maxX = Int(self.view.frame.size.width) - randomSquareSize
    let maxY = Int(self.view.frame.size.height - 44) - randomSquareSize
    
    let randomX = Int.random(1...maxX)
    let randomY = Int.random(1...maxY)
    
    self.directionsViewAxisX.constant = CGFloat(randomX)
    self.directionsViewAxisY.constant = CGFloat(randomY)
    
    self.directionsViewWidth.constant = CGFloat(randomSquareSize)
    self.directionsViewHeight.constant = CGFloat(randomSquareSize)
  }
  
  func addSwipeRecognizerForDirection(direction: UISwipeGestureRecognizerDirection) {
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
    swipeGesture.direction = direction //it's also possible to pass whole array here, but apparently in that case only left and right swipe works (Xcode 7.2)
    self.view.addGestureRecognizer(swipeGesture)
  }
  
  func handleSwipe(swipe: UISwipeGestureRecognizer) {
    let direction:DirectionsType = swipe.direction.translateToDirection()
    let result = DirectionsManager.sharedInstance.validateDirection(direction)
    self.scoreManager?.calculateScore(result)
    self.updateScoreView()
    
    self.setupDirections()
    self.setRandomPosition()
  }

  func updateScoreView() {
    if let updatePoints = self.updatePoints {
      if let score = self.scoreManager {
        updatePoints(points: score.userScore)
      }
    }
  }

}
