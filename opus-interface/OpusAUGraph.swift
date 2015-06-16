//
//  AudioGraphManager.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/12/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import AudioToolbox

class OpusAUGraph: NSObject {
  var _processingGraph: AUGraph
  var _samplerUnit: AudioUnit
  
  //MARK: Lifecycle
  override init() {

    _processingGraph = AUGraph()
    _samplerUnit = AudioUnit()
    
    super.init()
    
    setupAUGraph()
    graphStart()
  }
  
  func setupAUGraph() {
    var status = OSStatus(noErr)
    status = NewAUGraph(&_processingGraph)
    AudioToolboxError.handle(status)
    
    // create the sampler
    
    //https://developer.apple.com/library/prerelease/ios/documentation/AudioUnit/Reference/AudioComponentServicesReference/index.html#//apple_ref/swift/struct/AudioComponentDescription
    
    var samplerNode = AUNode()
    var cd = AudioComponentDescription(
      componentType: OSType(kAudioUnitType_MusicDevice),
      componentSubType: OSType(kAudioUnitSubType_Sampler),
      componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
      componentFlags: 0,
      componentFlagsMask: 0)
    
    status = AUGraphAddNode(_processingGraph, &cd, &samplerNode)
    AudioToolboxError.handle(status)
    
    // create the ionode
    var ioNode = AUNode()
    var ioUnitDescription = AudioComponentDescription(
      componentType: OSType(kAudioUnitType_Output),
      componentSubType: OSType(kAudioUnitSubType_RemoteIO),
      componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
      componentFlags: 0,
      componentFlagsMask: 0)
    
    status = AUGraphAddNode(_processingGraph, &ioUnitDescription, &ioNode)
    AudioToolboxError.handle(status)
    
    // now do the wiring. The graph needs to be open before you call AUGraphNodeInfo
    status = AUGraphOpen(_processingGraph)
    AudioToolboxError.handle(status)
    
    status = AUGraphNodeInfo(_processingGraph, samplerNode, nil, &_samplerUnit)
    AudioToolboxError.handle(status)
    
    var ioUnit  = AudioUnit()
    status = AUGraphNodeInfo(_processingGraph, ioNode, nil, &ioUnit)
    AudioToolboxError.handle(status)
    
    var ioUnitOutputElement = AudioUnitElement(0)
    var samplerOutputElement = AudioUnitElement(0)
    status = AUGraphConnectNodeInput(_processingGraph,
      samplerNode, samplerOutputElement, // srcnode, inSourceOutputNumber
      ioNode, ioUnitOutputElement) // destnode, inDestInputNumber
    AudioToolboxError.handle(status)
  }
  
  func graphStart() {
    //https://developer.apple.com/library/prerelease/ios/documentation/AudioToolbox/Reference/AUGraphServicesReference/index.html#//apple_ref/c/func/AUGraphIsInitialized
    
    var status = OSStatus(noErr)
    var outIsInitialized:Boolean = 0
    status = AUGraphIsInitialized(_processingGraph, &outIsInitialized)
    println("isinit status is \(status)")
    println("bool is \(outIsInitialized)")
    if outIsInitialized == 0 {
      status = AUGraphInitialize(_processingGraph)
      AudioToolboxError.handle(status)
    }
    
    var isRunning = Boolean(0)
    AUGraphIsRunning(_processingGraph, &isRunning)
    println("running bool is \(isRunning)")
    if isRunning == 0 {
      status = AUGraphStart(_processingGraph)
      AudioToolboxError.handle(status)
    }
    
    func loadPresets() {
      if let bankURL = NSBundle.mainBundle().URLForResource("gs_instruments", withExtension: "dls") {
        var instdata = AUSamplerInstrumentData(fileURL: Unmanaged.passUnretained(bankURL),
          instrumentType: UInt8(kInstrumentType_DLSPreset),
          bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
          bankLSB: UInt8(kAUSampler_DefaultBankLSB),
          presetID: 0)
        var status = AudioUnitSetProperty(
          _samplerUnit,
          UInt32(kAUSamplerProperty_LoadInstrument),
          UInt32(kAudioUnitScope_Global),
          0,
          &instdata,
          UInt32(sizeof(AUSamplerInstrumentData)))
        AudioToolboxError.handle(status)
      }
    }
  }
  
  deinit {
    var status = OSStatus(noErr)
    status = DisposeAUGraph(_processingGraph)
    AudioToolboxError.handle(status)
    
  }
  
  func getAUGraph() -> AUGraph {
    return _processingGraph
  }
}
