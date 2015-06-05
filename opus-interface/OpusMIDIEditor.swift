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
  
  //MARK: Accessors
  func getSequence() -> MusicSequence {
    return _musicSequence
  }
}