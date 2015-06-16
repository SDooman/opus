//
//  OpusNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import MusicKit
import AudioToolbox

public class OpusNote: NSObject, OpusStaffEvent, Equatable {
  
  var _pitch : Pitch
  
  var _beatLocation : MusicTimeStamp
  
  var _noteValue : OpusNoteValue
  
  init(pitch: Pitch, beatLocation: MusicTimeStamp,
    noteValue: OpusNoteValue) {
    
      _pitch = pitch
      _beatLocation = beatLocation
      _noteValue = noteValue
  }
  
  //MARK: Accessors
  
  func pitch() -> Pitch {
    return _pitch
  }
  
  func beatLocation() -> MusicTimeStamp {
    return _beatLocation
  }
  
  func noteValue() -> OpusNoteValue {
    return _noteValue
  }
  
  func midiNote() -> Float {
    return _pitch.midi
  }
}

//MARK: Operators

public func ==(lhs: OpusNote, rhs: OpusNote) -> Bool {
  return lhs.pitch() == rhs.pitch()
    && lhs.beatLocation() == rhs.beatLocation()
    && lhs.noteValue() == rhs.noteValue()
}