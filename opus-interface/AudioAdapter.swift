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
  var _midiPlayer: OpusAudioPlayer
  
  //MARK: Lifecycle
  
  init() {
    _audioGraph = OpusAUGraph()
    _midiSequenceEditor = OpusMIDIAdapter(auGraph: _audioGraph.getAUGraph())
    
    //println("finished creating sequence editor")
    _midiPlayer = OpusAudioPlayer(sequence: _midiSequenceEditor.getSequence())
    
  }
  
  deinit {
    
  }
  
  //MARK: Edit MIDI Sequence
  func insert(
    noteInformation: (UInt8, Float32, MusicTimeStamp)) -> Bool {
    
      return _midiSequenceEditor.insertNote(noteInformation.0,
        duration: noteInformation.1, time: noteInformation.2)
  }
  
  func edit(oldNoteInformation: (UInt8, Float32, MusicTimeStamp),
    newNoteInformation: (UInt8, Float32, MusicTimeStamp)) -> Bool {
      
      return _midiSequenceEditor.editNote(oldNoteInformation.0,
        duration: oldNoteInformation.1, time: oldNoteInformation.2,
        newNote: newNoteInformation.0,
        newDuration: newNoteInformation.1, newTime: newNoteInformation.2)
  }
  
  func remove(noteInformation: (UInt8, Float32, MusicTimeStamp)) -> Bool {
    
    return _midiSequenceEditor.deleteNote(noteInformation.0,
      duration: noteInformation.1, time: noteInformation.2)
  }
  
  //MARK: Music Playback
  func preparePlayback() -> Bool {
    return _midiPlayer.preparePlayback()
  }
  
  func startPlayback() -> Bool {
    return _midiPlayer.startPlaybackFromBeginning()
  }
  
  func stopPlayback() -> Bool {
    return _midiPlayer.stopPlayback()
  }
  
  func resumePlayback() -> Bool {
    return _midiPlayer.resetPlayback()
  }
  
  func getPlaybackTime() -> MusicTimeStamp {
    return _midiPlayer.getPlaybackTime()
  }
  
  func setPlaybackTime(intime: MusicTimeStamp) -> Bool {
    return _midiPlayer.setPlaybackTime(intime)
  }
  
  func resetPlaybackTime() -> Bool {
    return _midiPlayer.resetPlayback()
  }
  
  func isPlaying() -> Bool {
    return _midiPlayer.isPlaying()
  }
}