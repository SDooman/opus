//
//  StaffViewModel.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

//TODO: Make sure to replace all Audio playback with
//      Error throwing methods

class StaffViewModel: NSObject {
  
  
  //MARK: Staff Modification
  func insertNote(OpusNote) -> Bool {
    
      //TODO:(Sam) Fill out method stub
      return false
  }
  
  func insertRest(beat: MusicTimeStamp,
    duration: Float32) -> Bool {
      
      //TODO(Sam) Fill out method stub
      return false
  }
  
  func editNote(oldNote: OpusStaffObject, newNote: OpusStaffObject) -> Bool {
    return true
  }
  
  func removeNote(noteToRemove: OpusRest) -> Bool {
    
    return true
  }
  
  //MARK: Audio Playback
  
  func preparePlayback() -> Bool {
    return true
  }
  
  func startPlayback() -> Bool {
    return true
  }
  
  func stopPlayback() -> Bool {
    return true
  }
  
  func resumePlayback() -> Bool {
    return true
  }
  
  func getPlaybackTime() -> Bool {
    
    return true
  }
  
  func setPlaybackTime() -> Bool {
    
    return true
  }
  
  func resetPlayback() -> Bool {
    
    return true
  }
  
  func isPlaying() -> Bool {
    
    return true
  }
  
  //MARK: Exercise Management
  //TODO: We need to disucss this/figure out how it will work
  
  
}
