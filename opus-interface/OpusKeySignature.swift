//
//  OpusKeySignature.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import MusicKit

class OpusKeySignature: NSObject {

  let _typeOfAccidental : Accidental
  
  let _numberOfAccidentals : UInt16
  
  //TODO: [SD] Fill out
  var _pitches : PitchSet {
    
  }
  
  init(typeOfAccidental: Accidental, numberOfAccidentals: UInt16) {
    
    _typeOfAccidental = typeOfAccidental
    _numberOfAccidentals = numberOfAccidentals
  }
  
  //MARK: Accessors
  func typeOfAccidental() -> Accidental {
    return _typeOfAccidental
  }
  
  func numberOfAccidentals() -> UInt16 {
    return _numberOfAccidentals
  }
  
  func pitches() -> PitchSet {
    return _pitches
  }
  
  //MARK: Useful Default
  class func noAccidentals() -> OpusKeySignature {
    return OpusKeySignature(typeOfAccidental: Accidental.Natural,
      numberOfAccidentals: 0)
  }
}
