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
  
  //MARK: Useful Time Signature Defaults
  class func commonTime() -> OpusTimeSignature {
    return OpusTimeSignature(beats: 4, noteValue: OpusNoteValue.Quarter)
  }
  
  class func cutTime() -> OpusTimeSignature {
    return OpusTimeSignature(beats: 2, noteValue: OpusNoteValue.Half)
  }
}
