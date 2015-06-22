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
  
  //MARK: Accessing/Modifying Staff Events
}
