//
//  DataSource.swift
//  RightDirection
//
//  Created by Mike Mikina on 3/8/16.
//  Copyright © 2016 FDT. All rights reserved.
//

import Foundation

protocol DataSource {
  typealias U
  func prepareData() -> [U]
}