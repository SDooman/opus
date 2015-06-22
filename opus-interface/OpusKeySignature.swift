//
//  OpusKeySignature.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import MusicKit

class OpusKeySignature: NSObject {

  let _typeOfAccidental : Accidental
  
  let _numberOfAccidentals : UInt16
  
  //TODO: [SD] Create pitches field for
  //      getting pitches in a scale
  
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
  
  //MARK: Useful Default
  class func simpleKey() -> OpusKeySignature {
    return OpusKeySignature(typeOfAccidental: Accidental.Natural,
      numberOfAccidentals: 0)
  }
}
