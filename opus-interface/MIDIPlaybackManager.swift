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
    _musicPlayer = createMusicPlayer()
  }
  
  //MARK: MusicSequence Creation/Editing
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
  
  func hasMIDIEvent(note: UInt8, duration: Float32,
    beat: MusicTimeStamp) -> Bool {
    
      //TODO:(Sam) Fill In Method Stub
      return true
  }
  
  func insertMIDIEvent(note: UInt8, duration: Float32,
    beat: MusicTimeStamp) -> Bool {
    
      //TODO:(Sam) Fill In Method Stub
      return true
  }
  
  func removeMIDIEvent(note: UInt8, duration: Float32,
    beat: MusicTimeStamp) -> Bool {
    
      
      //TODO:(Sam) Fill In Method Stub
      return true
  }
  
  //MARK: MusicPlayer Functionality
  func createMusicPlayer() -> MusicPlayer {
    var musicPlayer = MusicPlayer()
    var status = OSStatus(noErr)
    status = NewMusicPlayer(&musicPlayer)
    
    if status != OSStatus(noErr) {
      println("bad status \(status) creating player")
      AudioToolboxError.handle(status)
    }
    
    status = MusicPlayerSetSequence(musicPlayer, _musicSequence)
    
    if status != OSStatus(noErr) {
      println("setting sequence \(status)")
      AudioToolboxError.handle(status)
    }
    
    status = MusicPlayerPreroll(musicPlayer)
    
    if status != OSStatus(noErr) {
      println("prerolling player \(status)")
      AudioToolboxError.handle(status)
    }

    return musicPlayer
  }
  
  
}
