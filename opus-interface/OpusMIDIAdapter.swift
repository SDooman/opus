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
  
  deinit {
    var status = OSStatus(noErr)
    DisposeMusicSequence(_musicSequence)
    AudioToolboxError.handle(status)
  }
  
  //MARK: Accessors
  
  func getSequence() -> MusicSequence {
    return _musicSequence
  }
  
  
  //MARK: Adding/Editing/Removing events
  func hasNote(note: UInt8, duration: Float32, time: MusicTimeStamp) -> Bool {
    
    func doesNoteExist(currentMIDINoteInfo: (UInt8, Float32, MusicTimeStamp),
      iterator: MusicEventIterator,
      targetNoteInformation: [(UInt8, Float32, MusicTimeStamp)]) -> Bool {
        
        var currentNote : UInt8 = currentMIDINoteInfo.0
        var currentDuration : Float32 = currentMIDINoteInfo.1
        var currentTime : MusicTimeStamp = currentMIDINoteInfo.2
        
        var targetNote : UInt8 = targetNoteInformation[0].0
        var targetTime : MusicTimeStamp = targetNoteInformation[0].2
        
        return currentNote == targetNote && currentTime == targetTime
    }
    
    return forEachMIDIEvent(doesNoteExist,
      midiEventData: (note, duration, time))
  }
  
  func hasExactNote(note: UInt8, duration: Float32, time: MusicTimeStamp) -> Bool {
    
    func doesExactNoteExist(currentMIDINoteInfo: (UInt8, Float32, MusicTimeStamp),
      iterator: MusicEventIterator,
      targetNoteInformation: [(UInt8, Float32, MusicTimeStamp)]) -> Bool {
        
        var currentNote : UInt8 = currentMIDINoteInfo.0
        var currentDuration : Float32 = currentMIDINoteInfo.1
        var currentTime : MusicTimeStamp = currentMIDINoteInfo.2
        
        var targetNote : UInt8 = targetNoteInformation[0].0
        var targetDuration : Float32 = targetNoteInformation[0].1
        var targetTime : MusicTimeStamp = targetNoteInformation[0].2
        
        return currentNote == targetNote && currentTime == targetTime
          && currentDuration == targetDuration
    }
    
    return forEachMIDIEvent(doesExactNoteExist,
      midiEventData: (note, duration, time))
  }
  
  func insertNote(note: UInt8, duration: Float32, time: MusicTimeStamp) -> Bool {
    
    if hasNote(note, duration: duration, time: time) {
      println("note already exists")
      return false
      
    } else {
      
      var status = OSStatus(noErr)
      var noteToInsert = MIDINoteMessage(channel: 0, note: note,
        velocity: 64, releaseVelocity: 0, duration: duration)
      
      status = MusicTrackNewMIDINoteEvent(_track, time, &noteToInsert)
      AudioToolboxError.handle(status)
      
      return true
    }
  }
  
  func editNote(note: UInt8, duration: Float32, time: MusicTimeStamp,
    newNote: UInt8, newDuration: Float32, newTime: MusicTimeStamp) -> Bool {
      
      func editTargetNode(currentMIDINoteInfo: (UInt8, Float32, MusicTimeStamp),
        iterator: MusicEventIterator,
        targetNoteInformation: [(UInt8, Float32, MusicTimeStamp)]) -> Bool {
          
          var currentNote : UInt8 = currentMIDINoteInfo.0
          var currentDuration : Float32 = currentMIDINoteInfo.1
          var currentTime : MusicTimeStamp = currentMIDINoteInfo.2
          
          var targetNote = targetNoteInformation[0].0
          var targetDuration = targetNoteInformation[0].1
          var targetTime = targetNoteInformation[0].2
          
          var updatedNote = targetNoteInformation[1].0
          var updatedDuration = targetNoteInformation[1].1
          var updatedTime = targetNoteInformation[1].2
          
          var musicEventType = MusicEventType(kMusicEventType_MIDINoteMessage)
          
          if currentNote == targetNote && currentTime == targetTime
            && currentDuration == targetDuration {
              
              var status = OSStatus(noErr)
              status = MusicEventIteratorSetEventTime(iterator, updatedTime)
              AudioToolboxError.handle(status)
              
              var updatedMIDINote = MIDINoteMessage(channel: 0,
                note: updatedNote, velocity: 64,
                releaseVelocity: 0, duration: updatedDuration)
              
              status = MusicEventIteratorSetEventInfo(iterator,
                musicEventType, &updatedMIDINote)
              AudioToolboxError.handle(status)
              
              return true
          }
          
          return false
      }
      
      return forEachMIDIEvent(editTargetNode,
        midiEventData: (note, duration, time), (newNote, newDuration, newTime))
  }
  
  func deleteNote(note: UInt8, duration: Float32, time: MusicTimeStamp) -> Bool {
    
    func removeTargetNote(currentMIDINoteInfo: (UInt8, Float32, MusicTimeStamp),
      iterator: MusicEventIterator,
      targetNoteInformation: [(UInt8, Float32, MusicTimeStamp)]) -> Bool {
      
        var currentNote : UInt8 = currentMIDINoteInfo.0
        var currentDuration : Float32 = currentMIDINoteInfo.1
        var currentTime : MusicTimeStamp = currentMIDINoteInfo.2
        
        var targetNote = targetNoteInformation[0].0
        var targetDuration = targetNoteInformation[0].1
        var targetTime = targetNoteInformation[0].2
        
        if currentNote == targetNote && currentTime == targetTime
          && currentDuration == targetDuration {
            
            var status = OSStatus(noErr)
            status = MusicEventIteratorDeleteEvent(iterator)
            AudioToolboxError.handle(status)
            
            return true
        }
        
        return false
    }
    
    return forEachMIDIEvent(removeTargetNote,
      midiEventData: (note, duration, time))
  }
  
  func forEachMIDIEvent(
    modifier: ((UInt8, Float32, MusicTimeStamp),
    MusicEventIterator, [(UInt8, Float32, MusicTimeStamp)]) -> Bool,
    midiEventData: (UInt8, Float32, MusicTimeStamp)...)
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
          
          var midiEvent =
          UnsafePointer<MIDINoteMessage>(eventData)
          
          
          hasPerformedTargetAction = modifier(
            (midiEvent.memory.note,
              midiEvent.memory.duration,
              currentTimeStamp),
            iterator,
            midiEventData)
        }
        
        status = MusicEventIteratorNextEvent(iterator)
        AudioToolboxError.handle(status)
      }
      
      status = DisposeMusicEventIterator(iterator)
      AudioToolboxError.handle(status)
      
      return hasPerformedTargetAction
  }
}
