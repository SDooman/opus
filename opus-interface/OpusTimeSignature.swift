//
//  OpusTimeSignature.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class OpusTimeSignature: NSObject {
  
  var _beatsPerMeasure : UInt16
  
  var _beatsPerMinute : UInt8
  
  var _noteValue : OpusNoteValue
  
  init(beatsPerMeasure: UInt16, beatsPerMinute: UInt8,
    noteValue: OpusNoteValue) {
      
      _beatsPerMeasure = beatsPerMeasure
      _beatsPerMinute = beatsPerMinute
      _noteValue = noteValue
  }
  
  //MARK: Accessors
  
  func beatsPerMeasure() -> UInt16 {
    return _beatsPerMeasure
  }
  
  func noteValue() -> OpusNoteValue {
    return _noteValue
  }
  
  func beatsPerMinute() -> UInt8 {
    return _beatsPerMinute
  }
  
  //MARK: Useful Time Signature Defaults
  class func commonTime() -> OpusTimeSignature {
    return OpusTimeSignature(beatsPerMeasure: 4,
      beatsPerMinute: 120, noteValue: OpusNoteValue.Quarter)
  }
  
  class func cutTime() -> OpusTimeSignature {
    return OpusTimeSignature(beatsPerMeasure: 2,
      beatsPerMinute: 120, noteValue: OpusNoteValue.Half)
  }
}
