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
  func insertNote(noteToInsert: OpusNote) -> Bool {
    
  }
  
  func editNote(noteToEdit: OpusNote, newPitch: Pitch,
    newBeat: MusicTimeStamp) -> Bool {
    
    
  }
  
  func removeNote(noteToRemove: OpusNote) -> Bool {
    
  }
  
  //MARK: Audio Playback
  
  func preparePlayback() -> Bool {
  
  }
  
  func startPlayback() -> Bool {
    
  }
  
  func stopPlayback() -> Bool {
    
  }
  
  func resumePlayback() -> Bool {
    
  }
  
  func getPlaybackTime() -> Bool {
    
  }
  
  func setPlaybackTime() -> Bool {
    
  }
  
  func resetPlayback() -> Bool {
    
  }
  
  func isPlaying() -> Bool {
    
  }
  
  //MARK: Exercise Management
  //TODO: We need to disucss this/figure out how it will work
  
  
}
