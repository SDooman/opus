//
//  OpusTimeSignature.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class OpusTimeSignature: NSObject {
  
  let _beats : UInt16
  
  let _noteValue : OpusNoteValue
  
  init(beats: UInt16, noteValue: OpusNoteValue) {
    _beats = beats
    _noteValue = noteValue
  }
  
  //MARK: Accessors
  
  func getBeats() -> UInt16 {
    return _beats
  }
  
  func getNoteValue() -> OpusNoteValue {
    return _noteValue
  }
}
