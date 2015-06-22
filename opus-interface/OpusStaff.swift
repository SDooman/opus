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
  
  let _staffEvents: [OpusStaffEvent]
  
  init(timeSignature: OpusTimeSignature,
    keySignature: OpusKeySignature) {
    
      
      _timeSignature = timeSignature
      _keySignature = keySignature
      _staffEvents = []
  }
  
  init(timeSignature: OpusTimeSignature,
    keySignature: OpusKeySignature,
    staffEvents: [OpusStaffEvent]) {
    
      _timeSignature = timeSignature
      _keySignature = keySignature
      _staffEvents = staffEvents
  }
  
  //MARK: Accessing/Modifying Staff Events
  
  func hasEvent(staffEvent: OpusStaffEvent) -> Bool {
    for event in _staffEvents {
      
    }
  }
  
  func doesNotHaveEvent(staffEvent: OpusStaffEvent) -> Bool {
    return !hasEvent(staffEvent)
  }
  
  func insert(staffEvent: OpusStaffEvent) -> Bool {
    
  }
  
  func edit(staffEvent: OpusStaffEvent,
    newStaffEvent: OpusStaffEvent) -> Bool {
    
  }
  
  func remove(staffEvent: OpusStaffEvent) {
    
  }
}
