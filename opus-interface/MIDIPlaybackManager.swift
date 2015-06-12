//
//  MIDIPlaybackManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import AudioToolbox

class MIDIPlaybackManager: AudioManager {
  
  var _audioGraphManager: OpusAUGraph
  var _musicPlayer: MusicPlayer = nil
  var _musicSequence: MusicSequence = nil
  
  init() {
    _audioGraphManager = OpusAUGraph()
    
    _musicSequence = createMusicSequence()
  }
  
  func createMusicSequence() -> MusicSequence {
    var musicSequence = MusicSequence()
    var status: OSStatus = NewMusicSequence(&musicSequence)
    
    AudioToolboxError.handle(status)
    
    var track = MusicTrack()
    status = MusicSequenceNewTrack(_musicSequence, &track)
    
    AudioToolboxError.handle(status)
    
    //Associate AUGraph 
    MusicSequenceSetAUGraph(musicSequence, _audioGraphManager.getAUGraph())
    
    return musicSequence
  }
  
}
