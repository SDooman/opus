//
//  PlayAudio.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/6/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

class ResumePlayback: Command {
  
  let invoker: PlaybackMenuViewController
  let target: StaffViewModel
  let editor: StaffEditorViewController
  
  init(invoker: PlaybackMenuViewController, target: StaffViewModel, editor: StaffEditorViewController) {
    
    self.invoker = invoker
    self.target = target
    self.editor = editor
  }
  
  func run() {
    
    //target.preparePlayback()
    target.resumePlayback()
    
  }
}