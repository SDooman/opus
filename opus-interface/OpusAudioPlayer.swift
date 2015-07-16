//
//  OpusMIDIPlayer.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class OpusAudioPlayer {
  
  var _sequence : MusicSequence = nil
  var _player : MusicPlayer = nil
  
  //MARK: Lifecycle
  
  init(sequence: MusicSequence) {
    _sequence = sequence
    
    _player = createPlayerWithSequence(_sequence)
  }
  
  func createPlayerWithSequence(sequence : MusicSequence) -> MusicSequence {
    var player = MusicPlayer()
    
    var status = OSStatus(noErr)
    status = NewMusicPlayer(&player)
    if status != OSStatus(noErr) {
      println("bad status \(status) creating player")
      AudioToolboxError.handle(status)
    }
    
    status = MusicPlayerSetSequence(player, sequence)
    if status != OSStatus(noErr) {
      println("setting sequence \(status)")
      AudioToolboxError.handle(status)
    }
    
    status = MusicPlayerPreroll(player)
    if status != OSStatus(noErr) {
      println("prerolling player \(status)")
      AudioToolboxError.handle(status)
    }
    
    return player
  }
  
  deinit {
    var status = OSStatus(noErr)
    status = DisposeMusicPlayer(_player)
    AudioToolboxError.handle(status)
  }
  
  //MARK: Playback functionality
  
  func preparePlayback() -> Bool {
    var status = OSStatus(noErr)
    status = MusicPlayerPreroll(_player)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    return true
  }
  
  func startPlaybackFromBeginning() -> Bool {
    var status = OSStatus(noErr)
    
    status = MusicPlayerSetTime(_player, 0)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    status = MusicPlayerStart(_player)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    return true
  }
  
  func stopPlayback() -> Bool {
    var status = OSStatus(noErr)
    status = MusicPlayerStop(_player)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    return true
  }
  
  func pausePlayback() -> Bool {
    var status = OSStatus(noErr)
    let time = getPlaybackTime()
    status = MusicPlayerStop(_player)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    setPlaybackTime(time)
    
    return true
  }
  
  func resumePlayback() -> Bool {
    var status = OSStatus(noErr)
    status = MusicPlayerStart(_player)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    return true
  }
  
  func getPlaybackTime() -> MusicTimeStamp {
    var time = MusicTimeStamp()
    
    var status = OSStatus(noErr)
    status = MusicPlayerGetTime(_player, &time)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
    }
    
    return time
  }
  
  func setPlaybackTime(intime: MusicTimeStamp) -> Bool {
    var status = OSStatus(noErr)
    status = MusicPlayerSetTime(_player, intime)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    return true
  }
  
  func resetPlayback() -> Bool {
    var status = OSStatus(noErr)
    
    status = MusicPlayerSetTime(_player, 0)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    return true
  }
  
  func isPlaying() -> Bool {
    var isPlaying = Boolean()
    var status = OSStatus(noErr)
    
    status = MusicPlayerIsPlaying(_player, &isPlaying)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
    }
    
    if isPlaying == 0 {
      return false
    }
    else {
      return true
    }
  }
}