//
//  SelectNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class SelectNoteAtLocation: Command {
  
  var invoker: StaffEditorViewController
  
  var location: CGPoint
  
  init(location: CGPoint,
    invoker: StaffEditorViewController) {

      self.invoker = invoker
      self.location = location
  }
  
  func run() {
    
    invoker.selectNoteAt(location)
  }
}