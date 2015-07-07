//
//  SelectNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class SelectNoteAtLocation: Command {
  
  let invoker: StaffEditorViewController
  let location: CGPoint
  
  init(location: CGPoint, invoker: StaffEditorViewController) {
    self.location = location
    self.invoker = invoker
  }
  
  func run() {
    invoker.selectNoteAt(location)
  }
}