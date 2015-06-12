//
//  MIDIPlaybackManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import AudioToolbox

class MIDIPlaybackManager: NSObject, AudioManager {
  
  var _audioGraphManager: AudioGraphManager
  var _musicPlayer: MusicPlayer
  var _musicSequence: MusicSequence
  
  override init() {
    _audioGraphManager = AudioGraphManager()
    _musicPlayer = nil
    _musicSequence = nil
  }
  
  
}
