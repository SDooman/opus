//
//  ClefKey.swift
//  opus-interface
//
//  Created by Nick DeMarco on 7/7/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import MusicKit

struct ClefKey {
  //MARK: - Getting Valid Locations on TrebleClef
  
  static let TREBLE_CLEF_MIDI_MIN : Int = 64 // E4
  
  static let TREBLE_CLEF_MIDI_MAX : Int = 77 // F5
  
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
    
    return myPitches.reverse()
  }
  
  /* HOW TO CALL THIS METHOD:
  
  let major = Scale.Major
  let cMajor = major(Pitch(chroma: Chroma.C, octave: 1)) // Octave is arbitrary, checking on treble clef only.
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

