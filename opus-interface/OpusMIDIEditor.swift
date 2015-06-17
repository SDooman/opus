//
//  OpusMIDIManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class OpusMIDIEditor {
  
  var _musicSequence: MusicSequence = nil
  var _track: MusicTrack = nil
  
  //MARK: Lifecycle
  
  init(auGraph: AUGraph) {
    
    _musicSequence = createMusicSequence(auGraph)
    
  }

  func createMusicSequence(auGraph: AUGraph) -> MusicSequence {
    var musicSequence = MusicSequence()
    var status: OSStatus = NewMusicSequence(&musicSequence)
    
    AudioToolboxError.handle(status)
    
    _track = MusicTrack()
    status = MusicSequenceNewTrack(_musicSequence, &_track)
    
    AudioToolboxError.handle(status)
    
    //Associate AUGraph
    MusicSequenceSetAUGraph(musicSequence, auGraph)
    
    return musicSequence
  }
  
  deinit {
    
  }
  
  //MARK: Accessors
  
  func getSequence() -> MusicSequence {
    return _musicSequence
  }
  
  //MARK: Adding/Editing/Removing events
  
  func hasMIDINote() -> Bool {
      
      var iterator = MusicEventIterator()
      
      var status = OSStatus(noErr)
      status = NewMusicEventIterator(_track, &iterator)
      
      if status != OSStatus(noErr) {
        AudioToolboxError.handle(status)
        return false
      }
      
      var hasCurrentEvent = Boolean()
      status = MusicEventIteratorHasCurrentEvent(iterator, &hasCurrentEvent)
      
      while hasCurrentEvent != 0 {
        
        //Do Work here
        var currentTimeStamp : MusicTimeStamp = 0
        var currentEventType : MusicEventType = 0
        var currentEventData : UnsafePointer<Void> = nil
        var currentDataSize : UInt32 = 0
        
        MusicEventIteratorGetEventInfo(iterator, &currentTimeStamp,
          &currentEventType, &currentEventData, &currentDataSize)
        
        if(currentEventType == kMusicEventType_MIDINoteMessage){
          
        }
        
        //Go to next event
        MusicEventIteratorNextEvent(iterator)
        AudioToolboxError.handle(status)
        
        MusicEventIteratorHasCurrentEvent(iterator, &hasCurrentEvent)
        AudioToolboxError.handle(status)
      }
      
      return false
  }
  
  func insertMIDINote(note: MIDINoteMessage, beat: MusicTimeStamp) -> Bool {
    var iterator = MusicEventIterator()
    
    var status = OSStatus(noErr)
    status = NewMusicEventIterator(_track, &iterator)
    
    if status != OSStatus(noErr) {
      AudioToolboxError.handle(status)
      return false
    }
    
    var hasCurrentEvent = Boolean()
    status = MusicEventIteratorHasCurrentEvent(iterator, &hasCurrentEvent)
    
    while hasCurrentEvent != 0 {
      
      //Do Work here
      
      
      
      //Go to next event
      MusicEventIteratorNextEvent(iterator)
      AudioToolboxError.handle(status)
      
      MusicEventIteratorHasCurrentEvent(iterator, &hasCurrentEvent)
      AudioToolboxError.handle(status)
    }
    
    return false
    
  }
  
  func editMIDINote() {
      
      
  }
  
  
}
