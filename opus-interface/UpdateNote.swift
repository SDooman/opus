//
//  UpdateNote.swift
//  opus-interface
//
//  Created by Nick DeMarco on 7/14/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class UpdateNote: Command {
  
  let invoker: StaffEditorViewController
  let target: StaffViewModel
  
  let oldNote: OpusNote
  let newNote: OpusNote
  
  init(oldNote: OpusNote, newNote: OpusNote,
    invoker: StaffEditorViewController,
    target: StaffViewModel) {
      
      self.oldNote = oldNote
      self.newNote = newNote
      self.invoker = invoker
      self.target = target

  }
  func run() {
    target.edit(oldNote, newStaffEvent: newNote)
    invoker.selectedNote!.note = self.newNote
  }
}
