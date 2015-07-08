//
//  DisplayNoteValueSelectionMenu.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit


class DisplayNoteSelectionMenu: Command {
  
  let location: CGPoint!
  let invoker: StaffEditorViewController!
  
  init(invoker: StaffEditorViewController, location: CGPoint) {
    self.location = location
    self.invoker = invoker
  }
  
  func run() {
    invoker.presentNoteValueSelectionMenuAt(location: location)
  }
}