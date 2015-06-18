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
    
    func doesNoteExist(currentMIDINoteMessage: UnsafePointer<MIDINoteMessage>,
      currentTime: MusicTimeStamp,
      iterator: MusicEventIterator,
      noteInformation: [(MIDINoteMessage, MusicTimeStamp)]) -> Bool {
        
        var currentNote = currentMIDINoteMessage.memory.note
        
        var targetNote = noteInformation[0].0.note
        var targetTime = noteInformation[0].1
        
        return currentNote == targetNote && currentTime == targetTime
    }
    
    return forEachMIDIEvent(doesNoteExist, midiEventData: (note, time))
  }
  
  func hasExactNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    
    func doesExactNoteExist(currentMIDINoteMessage: UnsafePointer<MIDINoteMessage>,
      currentTime: MusicTimeStamp,
      iterator: MusicEventIterator,
      noteInformation: [(MIDINoteMessage, MusicTimeStamp)]) -> Bool {
        
        var currentNote = currentMIDINoteMessage.memory.note
        var currentDuration = currentMIDINoteMessage.memory.note
        
        var targetNote = noteInformation[0].0.note
        var targetDuration = noteInformation[0].0.note
        var targetTime = noteInformation[0].1
        
        return currentNote == targetNote && currentTime == targetTime
          && currentDuration == targetDuration
    }
    
    return forEachMIDIEvent(doesExactNoteExist, midiEventData: (note, time))
  }
  
  func insertNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    
    if hasNote(note, time: time) {
      //TODO: (Sam) Clean up with error handling
      println("note already exists")
      return false
      
    } else {
      
      var status = OSStatus(noErr)
      var noteToInsert = MIDINoteMessage(channel: 0, note: note.note,
        velocity: 64, releaseVelocity: 0, duration: note.duration)
      
      status = MusicTrackNewMIDINoteEvent(_track, time, &noteToInsert)
      AudioToolboxError.handle(status)
      
      return true
    }
  }
  
  func editNote(note: MIDINoteMessage, time: MusicTimeStamp,
    newNote: MIDINoteMessage, newTime: MusicTimeStamp) -> Bool {
      
      return false
  }
  
  func deleteNote(note: MIDINoteMessage, time: MusicTimeStamp) -> Bool {
    
    func removeTargetNote(
      currentMIDINoteMessage: UnsafePointer<MIDINoteMessage>,
      currentTime: MusicTimeStamp,
      iterator: MusicEventIterator,
      noteInformation: [(MIDINoteMessage, MusicTimeStamp)]) -> Bool {
        
        var currentNote = currentMIDINoteMessage.memory.note
        var currentDuration = currentMIDINoteMessage.memory.note
        
        var targetNote = noteInformation[0].0.note
        var targetDuration = noteInformation[0].0.note
        var targetTime = noteInformation[0].1
        
        if currentNote == targetNote && currentTime == targetTime
          && currentDuration == targetDuration {
            
            var status = OSStatus(noErr)
            status = MusicEventIteratorDeleteEvent(iterator)
            AudioToolboxError.handle(status)
            
            return true
        }
        
        return false
    }
    
    return forEachMIDIEvent(removeTargetNote, midiEventData: (note, time))
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
