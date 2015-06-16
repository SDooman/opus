//
//  OpusRest.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox
import MusicKit

public class OpusRest: NSObject, OpusStaffEvent, Equatable {
  
  var _pitch : Pitch
  
  var _beatLocation : MusicTimeStamp
  
  var _noteValue : OpusNoteValue
  
  init(pitch: Pitch, beatLocation: MusicTimeStamp,
    noteValue: OpusNoteValue) {
      
      _pitch = pitch
      _beatLocation = beatLocation
      _noteValue = noteValue
  }
  
  func pitch() -> Pitch {
    return _pitch
  }
  
  func midiNote() -> Float {
    return _pitch.midi
  }
  
  func beatLocation() -> MusicTimeStamp {
    return _beatLocation
  }
  
  func noteValue() -> OpusNoteValue {
    return _noteValue
  }
}

public func ==(lhs: OpusRest, rhs: OpusRest) -> Bool {
  return lhs.pitch() == rhs.pitch()
    && lhs.beatLocation() == rhs.beatLocation()
    && lhs.noteValue() == rhs.noteValue()
}