//
//  OpusNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import MusicKit
import AudioToolbox

class OpusNote: NSObject, OpusStaffObject {
  
  var _pitch : Pitch
  
  var _beat : MusicTimeStamp
  
  var _noteValue : OpusNoteValue
  
  init(pitch: Pitch, beat: MusicTimeStamp,
    noteValue: OpusNoteValue) {
    
      _pitch = pitch
      _beat = beat
      _noteValue = noteValue
  }
  
  func getPitch() -> Pitch {
    return _pitch
  }
  
  func getMIDINote() -> Float {
    return _pitch.midi
  }
  
  func getBeat() -> MusicTimeStamp {
    return _beat
  }
  
  func getNoteValue() -> OpusNoteValue {
    return _noteValue
  }
}
