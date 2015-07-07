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
  
  //  Constants
  let horizontalSpaces = GraphicConstants().myHorizontalGridArray!
  let verticalSpaces = GraphicConstants().myVertLineSpaceArray!
  
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
    let distance = pow((touchOne.x - touchTwo.x), 2) + pow((touchOne.y - touchTwo.y), 2)
    return sqrt(distance) < 60.0
  }
  
  //TODO: [ND] Implement this.  
  //      Gives vertical and horizontal grid locked coordinate
  func closestValidPositionFrom(#location: CGPoint) -> CGPoint {
    let touchX = Float(location.x); let touchY = Float(location.y)
    var returnX: CGFloat? = nil;    var returnY: CGFloat? = nil

    for index in 0...horizontalSpaces.count - 1 {
      if touchX < horizontalSpaces[index] {
        returnX = CGFloat(horizontalSpaces[index])
        break
      }
    }

    for index in 0...verticalSpaces.count - 1 {
      if touchY < verticalSpaces[index]{
        returnY = CGFloat(verticalSpaces[index])
      }
    }
    
    if returnX == nil {
      returnX = CGFloat(horizontalSpaces.last!)
    }
    
    if returnY == nil {
      returnY = CGFloat(verticalSpaces.last!)
    }
    
    return CGPoint(x: returnX!, y: returnY!)
  }
  
  //TODO: [ND] Implement this
  func pitchFromBarLineIndex(barLineIndex: Int) -> Pitch {
    
    return Opus.trebleCMajor[barLineIndex]
  }
  
  //TODO: [ND] Implement this
  func beatLocationFrom(#location: CGPoint) -> MusicTimeStamp {
    let adjustedLocation = closestValidPositionFrom(location: location)
    var myBucket: Int!
    
    for i in 0...horizontalSpaces.count - 1 {
      if Float(adjustedLocation.x) == horizontalSpaces[i]{
        myBucket = i
        break
      }
    }
    
    return Float64(myBucket / 4)
    
  }
  
  //MARK: - UIScrollViewDelegate
  
  //MARK: - Drawing To Staff
  
}
