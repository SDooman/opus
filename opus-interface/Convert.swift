//
//  Convert.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/23/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class Convert {
  
  //TODO: Given a Time Signature, convert beat value to duration
  //      For now, assume everything is in 4/4 time
  private class func noteValueToDuration(noteValue: OpusNoteValue,
    timeSignature: OpusTimeSignature) -> Float32 {
      
      //Proportion of measure * beats per measure
      var beats : Float = noteValue.rawValue *
        Float(timeSignature.beatsPerMeasure())
      
      return Float32(beats)
  }
  
  class func opusNoteToMIDIInformation(opusNote: OpusNote,
    timeSignature: OpusTimeSignature) -> (UInt8, Float32, MusicTimeStamp) {
    
      var note : UInt8 = UInt8(floor(opusNote.pitch().midi))
      
      var noteValue = opusNote.noteValue()
      var duration = noteValueToDuration(noteValue, timeSignature: timeSignature)
      
      return (note, duration, opusNote.beatLocation())
  }
}