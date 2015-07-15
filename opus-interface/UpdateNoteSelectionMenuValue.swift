//
//  UpdateNoteSelectionMenuValue.swift
//  opus-interface
//
//  Created by Nick DeMarco on 7/7/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class UpdateNoteSelectionMenuValue : Command {
  
  let segmentationIndex: Int
  let subSegmentationIndex: Int
  let target: StaffEditorViewController
  let newValue: OpusNoteValue
  
  init(segIndex: Int, subSegIndex: Int, target: StaffEditorViewController, newValue: OpusNoteValue) {
    self.segmentationIndex = segIndex
    self.subSegmentationIndex = subSegIndex
    self.target = target
    self.newValue = newValue
  }
  
  func run() {
    target.setNoteValueMenuSelectedItem(segmentationIndex, subIndex: subSegmentationIndex, newRawValue: self.newValue.rawValue)
  }
}
