//
//  Opus.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/2/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import UIKit
import MusicKit

struct Opus {
  
  //MARK: - Radius allowed when touching note
  static let UINOTE_TOUCH_THRESHOLD : CGFloat = CGFloat(40.0)
  
  //MARK: - Note dimensions
  static let UINOTE_HEIGHT = UIScreen.mainScreen().bounds.height / 4.5
  
  static let UINOTE_WIDTH = UIScreen.mainScreen().bounds.width / 17
  
  //MARK: - Offsets for drawing notes to staff
  static let WHOLE_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 0)
  
  static let HALF_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 35)
  
  static let QUARTER_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 70)
  
  static let EIGHTH_NOTE_OFFSET : CGPoint = CGPoint(x: -15, y: 35)
  
  static let SIXTEENTH_NOTE_OFFSET : CGPoint = CGPoint(x: -15, y: 35)
  
}