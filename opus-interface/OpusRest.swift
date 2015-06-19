//
//  OpusRest.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox
import MusicKit

class OpusRest: NSObject, OpusStaffObject {
  
  var _beat : MusicTimeStamp
  
  var _duration : Float32
  
  var _pitch : Pitch
  
  init(beat: MusicTimeStamp,
    duration: Float32, pitch: Pitch) {
      
      _pitch = pitch
      _beat = beat
      _duration = duration
  }
  
  //TODO:(Sam) Fill in any other method stubs
  func getBeat() -> MusicTimeStamp {
    return _beat
  }
  
  func getDuration() -> Float32 {
    return _duration
  }
  
  func getPitch() -> Pitch {
    return _pitch
  }
}
