//
//  OpusStaffObject.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

protocol OpusStaffObject {
  
  func getBeat() -> MusicTimeStamp
  
  func getDuration() -> Float32
  
}