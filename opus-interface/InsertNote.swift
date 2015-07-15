//
//  InsertNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class InsertNote: Command {
  
  let invoker: StaffEditorViewController
  let target: StaffViewModel
  
  let note: OpusNote
  let location: CGPoint
  
  init(note: OpusNote, location: CGPoint,
    invoker: StaffEditorViewController,
    target: StaffViewModel) {
      
      self.note = note
      self.invoker = invoker
      self.target = target
      self.location = location
  }
  
  func run() {
    
    target.insert(note)
    
    invoker.displayNewNote(UINote(note: note, location: location))
    
    invoker.container.staffNavigator.insertNote(UINote(note: note, location: location))
    
  }
}