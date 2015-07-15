//
//  NewUINote.swift
//  opus-interface
//
//  Created by Samuel Dooman on 7/2/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import UIKit

class UINote: NSObject {
  
  var note : OpusNote?
  
  let image: UIImage?
  let imageView: UIImageView
  
  var noteValueOffset: CGPoint?
  var location: CGPoint
  
  let size: CGSize
  
  var noteCenter : CGPoint {
    return CGPoint(
      x: noteValueOffset!.x + imageView.center.x,
      y: noteValueOffset!.y + imageView.center.y)
  }
  
  //MARK: - Lifecycle
  
  init(note: OpusNote, location: CGPoint) {

    self.note = note
    
    var imageName: String
    
    switch note.noteValue {
      
    case OpusNoteValue.Whole:
      
      imageName = "whole_note"
      noteValueOffset = Opus.WHOLE_NOTE_OFFSET
      size = CGSizeMake(
        Opus.UINOTE_WIDTH_UNFLAGGED,
        Opus.UINOTE_HEIGHT)
      
    case OpusNoteValue.Half:
      
      imageName = "half_note"
      noteValueOffset = Opus.HALF_NOTE_OFFSET
      size = CGSizeMake(
        Opus.UINOTE_WIDTH_UNFLAGGED,
        Opus.UINOTE_HEIGHT)
      
    case OpusNoteValue.Quarter:
      
      imageName = "quarter_note"
      noteValueOffset = Opus.QUARTER_NOTE_OFFSET
      size = CGSizeMake(
        Opus.UINOTE_WIDTH_UNFLAGGED,
        Opus.UINOTE_HEIGHT)
      
    case OpusNoteValue.Eighth:
      
      imageName = "eighth_note"
      noteValueOffset = Opus.EIGHTH_NOTE_OFFSET
      size = CGSizeMake(
        Opus.UINOTE_WIDTH_FLAGGED,
        Opus.UINOTE_HEIGHT)
      
    case OpusNoteValue.Sixteenth:
      
      imageName = "sixteenth_note"
      noteValueOffset = Opus.SIXTEENTH_NOTE_OFFSET
      size = CGSizeMake(
        Opus.UINOTE_WIDTH_FLAGGED,
        Opus.UINOTE_HEIGHT)
      
    default:
      //TODO: [SD] Implement error handling
      //println("huh?")
      imageName = ""
      noteValueOffset = nil
      size = CGSizeMake(
        Opus.UINOTE_WIDTH_UNFLAGGED,
        Opus.UINOTE_HEIGHT)
    }
    
    image = UIImage(named: imageName)
    imageView = UIImageView(image: image)
    
    
    self.location = location
    //println("UINote Sets location to \(location)")
    
    super.init()
  }
  
  //MARK: - Accessors
  func updateLocation(location: CGPoint) {
    self.location = location
    
    imageView.center = CGPoint(
      x: location.x - noteValueOffset!.x,
      y: location.y - noteValueOffset!.y)
  }
}