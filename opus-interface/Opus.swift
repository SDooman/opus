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
  
  static let UINOTE_WIDTH_UNFLAGGED = UIScreen.mainScreen().bounds.width / 17
  
  static let UINOTE_WIDTH_FLAGGED = UIScreen.mainScreen().bounds.width / 9.4

  static let NAVNOTE_HEIGHT = UINOTE_HEIGHT / 3
  
  static let NAVNOTE_WIDTH = UINOTE_WIDTH_UNFLAGGED / 3
  
  //MARK: - Offsets for drawing notes to staff
  static let WHOLE_NOTE_OFFSET : CGPoint = CGPoint(x: -3, y: 70) // Good!
  
  static let HALF_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 70) // Good!
  
  static let QUARTER_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 70) // Good!
  
  static let EIGHTH_NOTE_OFFSET : CGPoint = CGPoint(x: -23, y: 70)
  
  static let SIXTEENTH_NOTE_OFFSET : CGPoint = CGPoint(x: -23, y: 70)
  
  //MARK: - Screen and Editor/Navigator Dimensions
  static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
  
  static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
  
  static let EDITOR_WIDTH = SCREEN_WIDTH
  
  // AS OF 7.13.15 static let EDITOR_HEIGHT = SCREEN_HEIGHT / 3
  
  static let EDITOR_TO_SCREEN_RATIO: CGFloat = CGFloat(1.5)
  
  static let STAFF_TO_EDITOR_RATIO: CGFloat = CGFloat(3)
  
  static let EDITOR_HEIGHT = SCREEN_HEIGHT / EDITOR_TO_SCREEN_RATIO
  
  static let STAFF_HEIGHT = EDITOR_HEIGHT / STAFF_TO_EDITOR_RATIO
  
  static let NAVIGATION_WIDTH = SCREEN_WIDTH
  
  static let NAVIGATION_HEIGHT = SCREEN_HEIGHT / 15
  
  static let EDITOR_TO_NAVIGATION_RATIO = EDITOR_HEIGHT / NAVIGATION_HEIGHT
  
  static let STAFF_IMAGE_WIDTH_HEIGHT_RATIO = 4
  
  
  
  //MARK: - Calculating "bucket" locations
  
  static let BUCKET_WIDTH = 64

  
  
  
  
}