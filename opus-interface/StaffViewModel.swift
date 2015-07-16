//
//  StaffViewModel.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox
import MusicKit

//TODO: Make sure to replace all Audio playback with
//      Error throwing methods

class StaffViewModel {
  
  var _staff : OpusStaff
  var _audioAdapter : AudioAdapter
  
  var currentNoteValue : OpusNoteValue
    = OpusNoteValue.Quarter
  
  init() {
    
    _staff = OpusStaff(timeSignature: OpusTimeSignature.commonTime(),
      keySignature: OpusKeySignature.noAccidentals())
    
    _audioAdapter = AudioAdapter()
    
    currentNoteValue = OpusNoteValue.Quarter
  }
  
  //MARK: Accessing Staff Information
  
  
  //MARK: Modifying Staff Contents
  //TODO: Refactor for all kinds of Staff Events
  func insert(newStaffEvent: OpusStaffEvent) -> Bool {
      
    let note = newStaffEvent as! OpusNote
    
    _staff.insert(note)
    _audioAdapter.insert(
      Convert.opusNoteToMIDIInformation(note,
        timeSignature: _staff.timeSignature()))
    
    return true
  }
  
  func edit(oldStaffEvent: OpusStaffEvent,
    newStaffEvent: OpusStaffEvent) -> Bool {
    
      let oldNote = oldStaffEvent as! OpusNote
      let newNote = newStaffEvent as! OpusNote
      
      _staff.edit(oldNote, newNote: newNote)
      
      //TODO: Remove this
      _staff.printStaff()
      
      _audioAdapter.edit(
        Convert.opusNoteToMIDIInformation(oldNote,
          timeSignature: _staff.timeSignature()),
        newNoteInformation:
        Convert.opusNoteToMIDIInformation(newNote,
          timeSignature: _staff.timeSignature()))
      
      return true
  }
  
  func remove(staffEvent: OpusStaffEvent) -> Bool {
    
    let note = staffEvent as! OpusNote
    
    _staff.remove(note)
    
    _audioAdapter.remove(Convert.opusNoteToMIDIInformation(note,
      timeSignature: _staff.timeSignature()))
    
    return true
  }
  
  //MARK: Audio Playback
  
  func preparePlayback() -> Bool {
    return _audioAdapter.preparePlayback()
  }
  
  func startPlayback() -> Bool {
    return _audioAdapter.startPlayback()
  }
  
  func stopPlayback() -> Bool {
    return _audioAdapter.stopPlayback()
  }
  
  func resumePlayback() -> Bool {
    return _audioAdapter.resumePlayback()
  }
  
  func getPlaybackTime() -> MusicTimeStamp {
    return _audioAdapter.getPlaybackTime()
  }
  
  func setPlaybackTime(time: MusicTimeStamp) -> Bool {
    return _audioAdapter.setPlaybackTime(time)
  }
  
  func resetPlayback() -> Bool {
    return _audioAdapter.resetPlaybackTime()
  }
  
  func isPlaying() -> Bool {
    return _audioAdapter.isPlaying()
  }
  
  //MARK: Exercise Management
  //TODO: We need to disucss this/figure out how it will work
  
  func printStaff() {
    var notes: [OpusNote] = []
    for event in _staff._staffEvents {
      notes.append(event)
    }
    
    println("there are \(_staff._staffEvents.count)")
    
    let sortedNotes = sorted(notes, sortFunc)
    
    for index in 0...sortedNotes.count - 1 {
      println("---Note \(index)---")
      println("Note at beat location: \(sortedNotes[index].beatLocation)")
      println("Has pitch: \(sortedNotes[index].pitch)")
      println("Has value: \(sortedNotes[index].noteValue.rawValue)")
      println("------------")
      
    }
    
  }
  
  func sortFunc(note1: OpusNote, note2: OpusNote) -> Bool {
    return note1.beatLocation < note2.beatLocation
  }
  
}
