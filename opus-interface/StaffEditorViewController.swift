//
//  StaffEditorViewController.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/29/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

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
  
  /*func noteIsAtLocation(note: UINote, location: CGPoint) -> Bool {
    
    
    let noteX = note.getNoteCenter().x
    let noteY = note.getNoteCenter().y
    
    let touchX = location.x
    let touchY = location.y

    
    
    if touchX >= noteX - sensitivity && touchX <= noteX + sensitivity {
      withinX = true
    }
    if touchY >= noteY - sensitivity && touchY <= noteY + sensitivity {
      withinY = true
    }
    return withinX && withinY
  }*/
  
  func selectNoteAt(location: CGPoint) {
    
    for note in notes {
      
      if noteIsAtLocation(note, location: location){
          
        selectedNote = note
        return
      }
    }
    
    selectedNote = nil
  }
  
  func noteIsAtLocation(note: UINote, location: CGPoint) -> Bool {
    return true
  }
  
  func twoTouchesAreAdjacent(#touchOne: CGPoint, touchTwo: CGPoint) -> Bool {
    //TODO: [ND] Implement
    return false
  }
  
  //MARK: - UIScrollViewDelegate
  
  //MARK: - Drawing To Staff
  
}
