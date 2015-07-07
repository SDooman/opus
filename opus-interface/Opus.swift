//
//  Opus.swift
//  opus-interface
//
//  Created by Nick DeMarco on 7/7/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import MusicKit

struct Opus {
  
  static let trebleClefRange: [Pitch] = [
    Pitch(chroma: Chroma.D, octave: 4),
    Pitch(chroma: Chroma.Ds, octave: 4),
    Pitch(chroma: Chroma.E, octave: 4),
    Pitch(chroma: Chroma.F, octave: 4),
    Pitch(chroma: Chroma.Fs, octave: 4),
    Pitch(chroma: Chroma.G, octave: 4),
    Pitch(chroma: Chroma.Gs, octave: 4),
    Pitch(chroma: Chroma.A, octave: 4),
    Pitch(chroma: Chroma.As, octave: 4),
    Pitch(chroma: Chroma.B, octave: 4),
    Pitch(chroma: Chroma.C, octave: 5),
    Pitch(chroma: Chroma.Cs, octave: 5),
    Pitch(chroma: Chroma.D, octave: 5),
    Pitch(chroma: Chroma.Ds, octave: 5),
    Pitch(chroma: Chroma.E, octave: 5),
    Pitch(chroma: Chroma.F, octave: 5),
    Pitch(chroma: Chroma.Fs, octave: 5),
    Pitch(chroma: Chroma.G, octave: 5)
  ]
  
  static func pitchesForScaleOnTrebleClef(#scale: PitchSet) -> [Pitch]{
    
    var myPitches: [Pitch] = []
    
    for possiblePitch in trebleClefRange {
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
  println(Opus.pitchesForScaleOnTrebleClef(scale: cMajor))
  */
  
}
