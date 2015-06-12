//
//  OpusNote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import MusicKit
import AudioToolbox

class OpusNote: NSObject, OpusStaffObject {
  
  var _pitch : Pitch
  
  var _beat : MusicTimeStamp
  
  var _duration : Float32
  
  init(pitch: Pitch, beat: MusicTimeStamp,
    duration: Float32, isRest: Bool) {
    
      _pitch = pitch
      _beat = beat
      _duration = duration
  }
  
  //TODO: (Sam) Fill out any methods that might be necessary
  func getPitch() -> Pitch {
    return _pitch
  }
  
  func getMIDINote() -> Float {
    return _pitch.midi
  }
  
  func getBeat() -> MusicTimeStamp {
    return _beat
  }
  
  func getDuration() -> Float32 {
    return _duration
  }
}
