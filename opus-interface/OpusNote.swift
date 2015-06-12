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
  
  let _pitch : Pitch
  
  let _beat : MusicTimeStamp
  
  let _duration : Float32
  
  let _isRest : Bool
  
  init(pitch: Pitch, beat: MusicTimeStamp,
    duration: Float32, isRest: Bool) {
    
      _pitch = pitch
      _beat = beat
      _duration = duration
      _isRest = isRest
  }
  
  //TODO: (Sam) Fill out any methods that might be necessary
  
}
