//
//  OpusStaff.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/5/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class OpusStaff: NSObject {
  
  let _timeSignature: OpusTimeSignature
  
  let _keySignature: OpusKeySignature
  
  //TODO: Replace with array of OpusStaffEvents if possible
  var _staffEvents: Set<OpusNote>
  
  //let _staffEvents: [OpusStaffEvent]
  
  init(timeSignature: OpusTimeSignature,
    keySignature: OpusKeySignature) {
      
      _timeSignature = timeSignature
      _keySignature = keySignature
      _staffEvents = Set<OpusNote>()
  }
  
  //MARK: Accessing Meta Information
  
  func timeSignature() -> OpusTimeSignature {
    return _timeSignature
  }
  
  func keySignature() -> OpusKeySignature {
    return _keySignature
  }
  
  //MARK: Dummy Methods
  //TODO: Replace these
  private func containsNote(targetNote: OpusNote) -> OpusNote? {
    for note in _staffEvents {
      if note == targetNote {
        return note
      }
    }
    return nil
  }
  
  func hasNote(targetNote: OpusNote) -> Bool {
    return containsNote(targetNote) != nil
  }
  
  func insert(note: OpusNote) -> Bool {
    if let target = containsNote(note) {
      return false
      
    } else {
      
      _staffEvents.insert(note)
      return true
    }
  }
  
  func edit(oldNote: OpusNote, newNote: OpusNote) -> Bool {
    println("Old Note: \(oldNote.pitch), \(oldNote.beatLocation)")
    println("New Note: \(newNote.pitch), \(newNote.beatLocation)")
    return insert(newNote) && remove(oldNote)
  }
  
  func remove(note: OpusNote) -> Bool {
    if let target = containsNote(note) {
      println("happened")
      _staffEvents.remove(note)
      return true
      
    } else {
      return false
    }
  }
  
  //MARK: Accessing/Modifying Staff Events
  
  /*func hasEvent(staffEvent: OpusStaffEvent) -> Bool {
    //TODO: (Sam) implement
    return true
  }
  
  func doesNotHaveEvent(staffEvent: OpusStaffEvent) -> Bool {
    return !hasEvent(staffEvent)
  }
  
  func insert(staffEvent: OpusStaffEvent) -> Bool {
    //TODO: (Sam) implement
    return true
  }
  
  func edit(staffEvent: OpusStaffEvent,
    newStaffEvent: OpusStaffEvent) -> Bool {
    
      return insert(newStaffEvent) && remove(staffEvent)
  }
  
  func remove(staffEvent: OpusStaffEvent) -> Bool {
    
    //TODO: (Sam) implement
    return true
  }*/
}
