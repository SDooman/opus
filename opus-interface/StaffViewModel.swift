//
//  StaffViewModel.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox
import MusicKit

//TODO: Make sure to replace all Audio playback with
//      Error throwing methods

class StaffViewModel: NSObject {
  
  override init() {
    
  }
  
  //MARK: Staff Modification
  func insert(newStaffObject: OpusStaffObject) -> Bool {
      
    //TODO:(Sam) Fill out method stub
    return false
  }
  
  func edit(oldNote: OpusStaffObject, newNote: OpusStaffObject) -> Bool {
    
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func remove(staffObject: OpusStaffObject) -> Bool {
    
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  //MARK: Audio Playback
  
  func preparePlayback() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func startPlayback() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func stopPlayback() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func resumePlayback() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func getPlaybackTime() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func setPlaybackTime() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func resetPlayback() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  func isPlaying() -> Bool {
    //TODO:(Sam) Fill out method stub
    return true
  }
  
  //MARK: Exercise Management
  //TODO: We need to disucss this/figure out how it will work
  
  
}
