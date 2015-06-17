//
//  OpusMIDIManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import AudioToolbox

class OpusMIDIAdapter {
  
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
  
  //MARK: Accessors
  
  func getSequence() -> MusicSequence {
    return _musicSequence
  }
  
  //MARK: Adding/Editing/Removing events
  
  //
  func hasNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    
    func ifNoteExists(currentNote: MIDINoteMessage,
      currentTime: MusicTimeStamp,
      iterator: MusicEventIterator,
      noteInformation: [(MIDINoteMessage, MusicTimeStamp)]) -> Bool {
        
        
        return false
    }
    
    return false
  }
  
  func hasExactNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    return false
  }
  
  func insertNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    return false
  }
  
  func editNote(note: MIDINoteMessage, time: MusicTimeStamp,
    newNote: MIDINoteMessage, newTime: MusicTimeStamp) -> Bool {
      
      return false
  }
  
  func deleteNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    
    return false
  }
  
  func forEachMIDIEvent(
    modifier: (UnsafePointer<MIDINoteMessage>, MusicTimeStamp,
    MusicEventIterator, [(MIDINoteMessage, MusicTimeStamp)]) -> Bool,
    midiEventData: (MIDINoteMessage, MusicTimeStamp)...)
    -> Bool {
      
      var iterator = MusicEventIterator()
      
      var status = OSStatus(noErr)
      status = NewMusicEventIterator(_track, &iterator)
      AudioToolboxError.handle(status)

      var hasCurrentEvent = Boolean()
      var hasPerformedTargetAction = false
      
      status = MusicEventIteratorHasCurrentEvent(iterator, &hasCurrentEvent)
      AudioToolboxError.handle(status)
      
      var currentTimeStamp : MusicTimeStamp = 0
      var eventType : MusicEventType = 0
      var eventData : UnsafePointer<Void> = nil
      var eventDataSize : UInt32 = 0
      
      while hasCurrentEvent != 0 && hasPerformedTargetAction {
        
        status = MusicEventIteratorGetEventInfo(iterator, &currentTimeStamp,
          &eventType, &eventData, &eventDataSize)
        AudioToolboxError.handle(status)
        
        if(Int(eventType) == Int(kMusicEventType_MIDINoteMessage)) {
          
          var currentMIDINoteMessage =
            UnsafePointer<MIDINoteMessage>(eventData)
          
          //TODO: (Sam) Finish this later
          
          hasPerformedTargetAction = modifier(currentMIDINoteMessage,
            currentTimeStamp, iterator, midiEventData)
        }
        
        status = MusicEventIteratorNextEvent(iterator)
        AudioToolboxError.handle(status)
      }
      
      status = DisposeMusicEventIterator(iterator)
      AudioToolboxError.handle(status)
      
      return hasPerformedTargetAction
  }
}
