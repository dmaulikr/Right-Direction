//
//  TimerManager.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/14/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

class TimerManager {
  var timer: NSTimer?
  var time = 0
  var completeCountdown: (()->())?
  var tick: ((Int)->())?
  
  // Starts countdown with given duration, every one second countdown function is called.
  func startCountdown(duration: Int) {
    self.time = duration
    self.timer?.invalidate()
    self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countdown"), userInfo: nil, repeats: true)
  }
  
  @objc func countdown() {
    // every second tick closure is called, this is just for view update
    if let tick = self.tick {
      tick(self.time)
    }
    
    // call completeCountdown closure after countdown has finish
    self.time -= 1
    if self.time < 0 {
      self.timer?.invalidate()
      if let complete = self.completeCountdown {
        complete()
      }
    }
  }
}