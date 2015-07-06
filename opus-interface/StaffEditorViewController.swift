//
//  StaffEditorViewController.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/29/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import MusicKit
import AudioToolbox

class StaffEditorViewController: UIViewController, UIScrollViewDelegate {
  
  //MARK: - Properties
  //TODO: [SD] Figure out best data structure for this
  //      Also resolve tech debt with only notes
  
  //  Graphics objects
  
  var notes : [UINote] = [UINote]()
  var selectedNote : UINote?
  
  var container : StaffContainerViewController {
    
    return parentViewController as! StaffContainerViewController
  }
  
  var staffViewModel : StaffViewModel {
    return container.staffViewModel
  }
  
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //TODO: Fill in method stub
  func setupGestureRecognizers() {
    
  }
  
  //MARK: - Gesture Event Callbacks
  
  //TODO: Fill in method stubs
  
  func oneFingerSingleTap(gestureRecognizer: UITapGestureRecognizer) {
    
    let touchLocation = gestureRecognizer.locationInView(view)
    
    //TODO: Launch command for selecting note
    
  }
  
  func twoFingerSingleTap(gestureRecognizer: UITapGestureRecognizer) {
    
    let midpointLocation =
      gestureRecognizer.locationInView(view)
    
    let touch1Location =
      gestureRecognizer.locationOfTouch(0, inView: view)
    let touch2Location =
      gestureRecognizer.locationOfTouch(1, inView: view)
    
    if twoTouchesAreAdjacent(touchOne: touch1Location,
      touchTwo: touch2Location) {
        
        //TODO: Command for displaying menu goes here
    }
  }
  
  func oneFingerDrag(gestureRecognizer: UITapGestureRecognizer) {
    
    switch gestureRecognizer.state {
      
    case UIGestureRecognizerState.Began:
      println("")
      
    case UIGestureRecognizerState.Changed:
      println("")
      
    case UIGestureRecognizerState.Ended:
      println("")
      
    default:
      println("")
      
    }
  }
  
  func twoFingerDrag(gestureRecognizer: UIPanGestureRecognizer) {
    
  }
  
  //MARK: - Graphics Helper Functions
  //TODO: - Should these be in their own class?
  
  func noteIsAtLocation(note: UINote, location: CGPoint) -> Bool {
    
    let noteX = note.noteCenter.x
    let noteY = note.noteCenter.y
    
    let touchX = location.x
    let touchY = location.y
    
    return abs(noteX - touchX) < Opus.UINOTE_TOUCH_THRESHOLD
      && abs(noteY - touchY) < Opus.UINOTE_TOUCH_THRESHOLD
  }
  
  func selectNoteAt(location: CGPoint) {
    for note in notes {
      if noteIsAtLocation(note, location: location){
        selectedNote = note
        return
      }
    }
    selectedNote = nil
  }
  
  func twoTouchesAreAdjacent(#touchOne: CGPoint, touchTwo: CGPoint) -> Bool {
    //TODO: [ND] Implement implement this
    return false
  }
  
  //TODO: [ND] Implement this.  
  //      Gives vertical and horizontal grid locked coordinate
  func closestValidPositionFrom(#location: CGPoint) -> CGPoint {
    return CGPoint(x: 0, y: 0)
  }
  
  //TODO: [ND] Implement this
  func pitchFromBarLineIndex(barLineIndex: Int) -> Pitch {
    return Pitch(midi: 60)
  }
  
  //TODO: [ND] Implement this
  func beatLocationFrom(#location: CGPoint) -> MusicTimeStamp {
    return 0
  }
  
  //MARK: - UIScrollViewDelegate
  
  //MARK: - Drawing To Staff
  
}
