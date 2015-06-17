//
//  AudioManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class AudioAdapter {
  
  var _audioGraph: OpusAUGraph
  var _midiSequenceEditor: OpusMIDIAdapter
  var _midiPlayer: OpusMIDIPlayer
  
  init() {
    _audioGraph = OpusAUGraph()
    _midiSequenceEditor = OpusMIDIAdapter(auGraph: _audioGraph.getAUGraph())
    _midiPlayer = OpusMIDIPlayer(sequence: _midiSequenceEditor.getSequence())
    
  }
  
  //MARK: Lifecycle
  
  //MARK: Edit MIDI Sequence
  
  
  //MARK: Music Playback
  
  //MARK: Access fields
}