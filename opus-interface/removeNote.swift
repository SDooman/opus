//
//  removeNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class RemoveNote: Command {
  
  let invoker: StaffEditorViewController
  let target: StaffViewModel
  
  let note: OpusNote
  let location: CGPoint
  
  init(note: OpusNote, location: CGPoint, invoker: StaffEditorViewController, target: StaffViewModel) {
    
    self.note = note
    self.location = location
    self.target = target
    self.invoker = invoker
  }
  
  func run() {
    
    target.remove(note)
    
    invoker.removeExistingNote(UINote(note: note, location: location))
    
  }
}