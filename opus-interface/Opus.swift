//
//  Opus.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/2/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import UIKit
import MusicKit

struct Opus {
  
  //MARK: - Radius allowed when touching note
  static let UINOTE_TOUCH_THRESHOLD : CGFloat = CGFloat(40.0)
  
  //MARK: - Note dimensions
  static let UINOTE_HEIGHT = UIScreen.mainScreen().bounds.height / 4.5
  
  static let UINOTE_WIDTH = UIScreen.mainScreen().bounds.width / 17
  
  //MARK: - Offsets for drawing notes to staff
  static let WHOLE_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 0)
  
  static let HALF_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 35)
  
  static let QUARTER_NOTE_OFFSET : CGPoint = CGPoint(x: 0, y: 70)
  
  static let EIGHTH_NOTE_OFFSET : CGPoint = CGPoint(x: -15, y: 35)
  
  static let SIXTEENTH_NOTE_OFFSET : CGPoint = CGPoint(x: -15, y: 35)
  
  //MARK: - Getting Valid Locations on TrebleClef [TECHNICAL DEBT HARD CODED HERE]
  
  static let TREBLE_CLEF_MIDI_MIN : Int = 74 // D4
  
  static let TREBLE_CLEF_MIDI_MAX : Int = 91 // G5
  
  static let BASS_CLEF_MIDI_MIN : Int = -1 // TO BE IMPLEMENTED LATER
  
  static let BASS_CLEF_MIDI_MAX : Int = -1 // TO BE IMPLEMENTED LATER

  //MARK: - Functions for calculating treble-limits to scale
  
  static func pitchesForScaleOnClef(#scale: PitchSet, clef: Clef) -> [Pitch]{
    
    var myPitches: [Pitch] = []
    let clefRange: [Pitch]
    
    switch clef {
    case .Bass :
      clefRange = createClefRangeFrom(minMidi: BASS_CLEF_MIDI_MIN, maxMidi: BASS_CLEF_MIDI_MAX)
    case .Treble:
      clefRange = createClefRangeFrom(minMidi: TREBLE_CLEF_MIDI_MIN, maxMidi: TREBLE_CLEF_MIDI_MAX)
    }
    
    for possiblePitch in clefRange {
      let possibleChroma = possiblePitch.chroma!
      let checkPitch = Pitch(chroma: possibleChroma, octave: 1)
      let checkPitch2 = Pitch(chroma: possibleChroma, octave: 2) // C will be one octave higher in notation.
      if scale.contains(checkPitch) || scale.contains(checkPitch2){
        myPitches.append(possiblePitch)
      }
    }

    return myPitches
  }
  
  /* HOW TO CALL THIS METHOD:
  
  let major = Scale.Major
  let cMajor = major(Pitch(chroma: Chroma.C, octave: 1)) // Octave is arbitrary, checking on treble clef only.
  println(Opus.pitchesForScaleOnTrebleClef(scale: cMajor, clef: .Treble))
  */
  
  static func createClefRangeFrom(#minMidi: Int, maxMidi: Int) -> [Pitch] {
    var toReturn: [Pitch] = []
    for midiIndex in minMidi...maxMidi + 1 {
      let pitch = Pitch(midi: Float(midiIndex))
      toReturn.append(pitch)
    }
    return toReturn
  }
  
  static func createClefRangeFrom(#rangeArray: [Int]) -> [Pitch] {
    assert(rangeArray.count == 2, "Range can only contain two integers")
    var toReturn: [Pitch] = []
    for midiIndex in rangeArray[0]...rangeArray[1] + 1 {
      let pitch = Pitch(midi: Float(midiIndex))
      toReturn.append(pitch)
    }
    return toReturn
  }
  
}

enum Clef {
  case Bass, Treble
}
