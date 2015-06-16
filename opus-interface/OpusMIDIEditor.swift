//
//  OpusMIDIManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class OpusMIDIEditor {
  
  var _musicSequence: MusicSequence = nil
  
  //MARK: Lifecycle
  
  init(auGraph: AUGraph) {
    
    _musicSequence = createMusicSequence(auGraph)
  }

  func createMusicSequence(auGraph: AUGraph) -> MusicSequence {
    var musicSequence = MusicSequence()
    var status: OSStatus = NewMusicSequence(&musicSequence)
    
    AudioToolboxError.handle(status)
    
    var track = MusicTrack()
    status = MusicSequenceNewTrack(_musicSequence, &track)
    
    AudioToolboxError.handle(status)
    
    //Associate AUGraph
    MusicSequenceSetAUGraph(musicSequence, auGraph)
    
    return musicSequence
  }
  
  deinit {
    
  }
  
  //MARK: Adding/Editing/Removing events
  
  func hasMIDINote(note: UInt8, beat: MusicTimeStamp,
    duration: Float32) -> Bool {
      
      
  }
  
  func insertMIDINote(note: UInt8, beat: MusicTimeStamp,
    duration: Float32) {
      
      
  }
  
  func editMIDINote(currNote: UInt8, currBeat: MusicTimeStamp,
    currDuration: Float32, newNote: UInt8,
    newBeat: MusicTimeStamp, newDuration: Float32) {
      
      
  }
  
  //MARK: Accessors
  func getSequence() -> MusicSequence {
    return _musicSequence
  }
}