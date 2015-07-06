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
  
  var pitch : Pitch
  
  var beatLocation : MusicTimeStamp
  
  var noteValue : OpusNoteValue
  
  init(pitch: Pitch, beatLocation: MusicTimeStamp,
    noteValue: OpusNoteValue) {
    
      self.pitch = pitch
      self.beatLocation = beatLocation
      self.noteValue = noteValue
  }
}

//MARK: Operators

public func ==(lhs: OpusNote, rhs: OpusNote) -> Bool {
  return lhs.pitch == rhs.pitch
    && lhs.beatLocation == rhs.beatLocation
    && lhs.noteValue == rhs.noteValue
}