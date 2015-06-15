//
//  OpusMIDIPlayer.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class OpusMIDIPlayer {
  
  var _sequence : MusicSequence
  
  
  //MARK: Lifecycle
  
  init(sequence: MusicSequence) {
    _sequence = sequence
  }
  
  deinit {
    
  }
  
  //MARK: Inserting/Editing/Deleting MIDI events
  
  func insertMIDINote(note: UInt8, beat: MusicTimeStamp,
    duration: Float32) {
      
      
  }
  
  func editMIDINote(currNote: UInt8, currBeat: MusicTimeStamp,
    currDuration: Float32, newNote: UInt8,
    newBeat: MusicTimeStamp, newDuration: Float32) {
    
      
  }
}