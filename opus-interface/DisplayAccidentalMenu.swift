//
//  DisplayAccidentalMenu.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

class DisplayAccidentalMenu: Command {
  
  let note: UINote
  let invoker: StaffEditorViewController
  
  init(note: UINote, invoker: StaffEditorViewController) {
    self.note = note
    self.invoker = invoker
  }
  
  func run() {
    
    //invoker.presentAccidentalMenuOnNote(note)
    
  }
}