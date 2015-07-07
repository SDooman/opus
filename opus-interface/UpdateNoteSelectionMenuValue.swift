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
  
  init(segIndex: Int, subSegIndex: Int, target: StaffEditorViewController) {
    self.segmentationIndex = segIndex
    self.subSegmentationIndex = subSegIndex
    self.target = target
  }
  
  func run() {
    target.setNoteValueMenuSelectedItem(segmentationIndex, subIndex: subSegmentationIndex)
  }
}
