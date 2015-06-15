//
//  AudioManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class OpusAudioManager {
  
  var _audioGraph: OpusAUGraph
  var _midiSequenceEditor: OpusMIDIEditor
  var _midiPlayer: OpusMIDIPlayer
  
  init() {
    _audioGraph = OpusAUGraph()
    _midiSequenceEditor = OpusMIDIEditor(auGraph: _audioGraph.getAUGraph())
    _midiPlayer = OpusMIDIPlayer(sequence: _midiSequenceEditor.getSequence())
    
  }
  
  //MARK: Lifecycle
  
  //MARK: Edit MIDI Sequence
  
  //MARK: Music Playback
  
  //MARK: Access fields
  
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
}