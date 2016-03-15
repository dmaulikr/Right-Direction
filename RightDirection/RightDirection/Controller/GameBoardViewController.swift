//
//  GameBoardViewController.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/3/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
  let topBarHeight = 44 //size of top navigation bar, navbar here it's just normal UIView
  let minDirectionViewSquare = 200 //minimum size of view with directions
  let maxDirectionViewSquare = 250 //maximum size of view with directions
  let playTime = 60
  
  @IBOutlet weak var directionsViewHeight: NSLayoutConstraint!
  @IBOutlet weak var directionsViewWidth: NSLayoutConstraint!
  @IBOutlet weak var directionsViewAxisX: NSLayoutConstraint!
  @IBOutlet weak var directionsViewAxisY: NSLayoutConstraint!
  
  @IBOutlet weak var directionsView: DirectionsView!
  var scoreManager: ScoreManager?
  var timeManager: TimerManager?
  var updatePoints: ((points: Int) -> ())?
  var updateTime: ((time: Int) -> ())?
  var badgeView: BadgeView?
  
  // When false we block all swipe gestures,
  // game is inactive at the begining and at the end when time pass
  var isGameActive = false
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setup()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.prepareMessageView()
  }
  
  func startGame() {
    self.isGameActive = true
    self.timeManager?.startCountdown(self.playTime)
    self.setupDirections()
    self.setRandomPosition()
  }
  
  func finishGame() {
    self.isGameActive = false
    self.directionsView.cleanUp()
    
  }
  
  func setup() {
    self.scoreManager = ScoreManager()
    self.setupView()
    
    self.timeManager = TimerManager()
    if let update = self.updateTime, time = self.timeManager {
      // This closure is called every second the timer is running, we use it
      // to run another closure which updates label in GameTabVC
      time.tick = { timeValue in
        update(time: timeValue)
      }
      
      // This closure is called when timer finish countdown
      time.completeCountdown = {
        self.finishGame()
      }
    }
  }
  
  func setupView() {
    for direction in [.Right, .Left, .Up, .Down] as [UISwipeGestureRecognizerDirection] {
      self.addSwipeRecognizerForDirection(direction)
    }
    
    if let badge = NSBundle.mainBundle().loadNibNamed("BadgeView", owner: self, options: nil)[0] as? BadgeView {
      self.view.addSubview(badge)
      self.badgeView = badge
      badge.translatesAutoresizingMaskIntoConstraints = false
      badge.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
      badge.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
      badge.widthAnchor.constraintEqualToConstant(CGFloat(badge.badgeViewWidth)).active = true
      badge.heightAnchor.constraintEqualToConstant(CGFloat(badge.badgeViewHeight)).active = true
      badge.layer.cornerRadius = CGFloat(badge.badgeRoundedCorners)
    }
  }
  
  func prepareMessageView() {
    if let mView = NSBundle.mainBundle().loadNibNamed("MessageView", owner: self, options: nil)[0] as? MessageView {
      self.view.addSubview(mView)
      mView.showMessages([NSLocalizedString("Prepare...", comment: "Prepare..."), NSLocalizedString("3", comment: "3"), NSLocalizedString("2", comment: "2"), NSLocalizedString("1", comment: "1"), NSLocalizedString("Go!", comment: "Go!")])
      mView.translatesAutoresizingMaskIntoConstraints = false
      mView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
      mView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
      mView.widthAnchor.constraintEqualToConstant(CGFloat(mView.messageViewWidth)).active = true
      mView.heightAnchor.constraintEqualToConstant(CGFloat(mView.messageViewHeight)).active = true
      mView.layer.cornerRadius = CGFloat(mView.messageRoundedCorners)
      mView.completion = {
        mView.removeFromSuperview()
        self.startGame()
      }
    }
  }
  
  func setupDirections() {
    self.directionsView.cleanUp()
    
    if let directions = NSBundle.mainBundle().loadNibNamed("DirectionsView", owner: self, options: nil)[0] as? DirectionsView {
      directions.datasource = DirectionsManager.sharedInstance.getItem()
      directions.setup()
      self.directionsView.addSubview(directions)
      directions.translatesAutoresizingMaskIntoConstraints = false
      directions.pin(self.directionsView, direction: .Left)
      directions.pin(self.directionsView, direction: .Right)
      directions.pin(self.directionsView, direction: .Up)
      directions.pin(self.directionsView, direction: .Down)
    }
  }
  
  func setRandomPosition() {
    let randomSquareSize = Int.random(self.minDirectionViewSquare...self.maxDirectionViewSquare)
    
    let maxX = Int(self.view.frame.size.width) - randomSquareSize
    let maxY = Int(self.view.frame.size.height - CGFloat(self.topBarHeight)) - randomSquareSize
    
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
    if !self.isGameActive {
      return
    }
    
    let direction: DirectionsType = swipe.direction.translateToDirection()
    let result = DirectionsManager.sharedInstance.validateDirection(direction)
    self.scoreManager?.calculateScore(result)
    self.badgeView?.setupBadgeWithResult(result)
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
