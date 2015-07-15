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

class StaffEditorViewController: UIViewController, UIGestureRecognizerDelegate {
  
  //MARK: - Properties
  //TODO: [SD] Figure out best data structure for this
  //      Also resolve tech debt with only notes
  
  //  Graphics objects
  
  var notes : Set<UINote> = []
  var selectedNote : UINote?
  
  // Scrolling Objects
  var staffEditorScrollView: StaffEditorScrollView?
  let staffImageView: UIImageView
  let elongationConstant: CGFloat
  let initialStaffWidth: CGFloat
  let viewControllerFrame: CGRect
  let imageViewFrame: CGRect
  
  //  Note Drawing Constants
  let verticalSpaces: [Float] = [179, 199.5, 220, 240.5, 261, 281.5, 302, 322, 342]
  
  // Used for NoteValueSelectionVC - indices for previously selected element.
  var currentSegControlIndex: Int = -1
  var currentSubSegControlIndex: Int = -1
  
  // Computed Properties

  var container : StaffContainerViewController {
    return parentViewController as! StaffContainerViewController
  }
  
  var staffViewModel : StaffViewModel {
    return container.staffViewModel
  }
  
  
  //MARK: - Initializers
  init() {
    elongationConstant = Opus.EDITOR_WIDTH
    initialStaffWidth = Opus.EDITOR_WIDTH * 2
    
    let ratio = Opus.EDITOR_TO_SCREEN_RATIO
    let editorHeight = Opus.EDITOR_HEIGHT
    let editorWidth = Opus.EDITOR_WIDTH
    
    var frameTopLeftCorner = CGPointMake(0, (Opus.SCREEN_HEIGHT - Opus.EDITOR_HEIGHT) / 2)
    
    viewControllerFrame = CGRect(x: frameTopLeftCorner.x,
      y: frameTopLeftCorner.y,
      width: editorWidth,
      height: editorHeight)
    
    imageViewFrame = CGRect(x: 0,
      y: ((editorHeight - Opus.STAFF_HEIGHT) / 2),
      width: initialStaffWidth,
      height: Opus.STAFF_HEIGHT)
    
    let staffImage = UIImage(named: "staff_vector")
    staffImageView = UIImageView(image: staffImage)
    staffImageView.frame = imageViewFrame
    
    super.init(nibName: nil, bundle: nil)
    
  }

  required init(coder aDecoder: NSCoder) {
    elongationConstant = Opus.EDITOR_WIDTH
    initialStaffWidth = Opus.EDITOR_WIDTH * 2
    
    let ratio = Opus.EDITOR_TO_SCREEN_RATIO
    let editorHeight = Opus.EDITOR_HEIGHT
    let editorWidth = Opus.EDITOR_WIDTH
    
    var frameTopLeftCorner = CGPointMake(0, (Opus.SCREEN_HEIGHT - Opus.EDITOR_HEIGHT) / 2)
    
    viewControllerFrame = CGRect(x: frameTopLeftCorner.x,
      y: frameTopLeftCorner.y,
      width: editorWidth,
      height: editorHeight)
    
    imageViewFrame = CGRect(x: 0,
      y: ((editorHeight - Opus.STAFF_HEIGHT) / 2),
      width: initialStaffWidth,
      height: Opus.STAFF_HEIGHT)
    
    let staffImage = UIImage(named: "staff_vector")
    staffImageView = UIImageView(image: staffImage)
    staffImageView.frame = imageViewFrame

    super.init(coder: aDecoder)
  
  }
  
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.frame = viewControllerFrame
    
    setUpStaff()
    setupGestureRecognizers()
    self.view.backgroundColor = UIColor.redColor()
    
    staffEditorScrollView!.addSubview(staffImageView)
    self.view.addSubview(staffEditorScrollView!)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  func setUpStaff(){
    
    staffEditorScrollView = StaffEditorScrollView(size: viewControllerFrame.size, owner: self)
    //staffEditorScrollView!.showsHorizontalScrollIndicator = false
    staffEditorScrollView!.userInteractionEnabled = true
    staffEditorScrollView!.bounces = false
    staffEditorScrollView!.indicatorStyle = UIScrollViewIndicatorStyle.White
    staffEditorScrollView!.frame.size = viewControllerFrame.size
    staffEditorScrollView!.contentSize = imageViewFrame.size
  }
  
  //TODO: Fill in method stub
  func setupGestureRecognizers() {
    let singleSelector: Selector = "oneFingerSingleTap:"
    var singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: singleSelector)
    singleTap.numberOfTapsRequired = 1
    singleTap.delegate = self
    self.view.addGestureRecognizer(singleTap)
    
    let dragSelector: Selector = "oneFingerDrag:"
    var dragRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: dragSelector)
    dragRecognizer.minimumNumberOfTouches = 1
    dragRecognizer.maximumNumberOfTouches = 1
    dragRecognizer.delegate = self
    self.view.addGestureRecognizer(dragRecognizer)
    
    let twoFingerSingleTapSelector: Selector = "twoFingerSingleTap:"
    var twoFingerSingleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: twoFingerSingleTapSelector)
    twoFingerSingleTap.numberOfTouchesRequired = 2
    twoFingerSingleTap.delegate = self
    self.view.addGestureRecognizer(twoFingerSingleTap)
    
  }
  
  //MARK: - Gesture Event Callbacks
  
  //TODO: Fill in method stubs
  
  func oneFingerSingleTap(gestureRecognizer: UITapGestureRecognizer) {
    
    let touchLocation = gestureRecognizer.locationInView(self.staffEditorScrollView!)
    let adjustedLocation = closestValidPositionFrom(location: touchLocation)
    
    let barLineIndex: Int
    let pitch: Pitch
    let noteValue: OpusNoteValue
    let beatLocation: MusicTimeStamp
    
    selectNoteAt(adjustedLocation)

    if selectedNote == nil {
      barLineIndex = barLineIndexFrom(adjustedLocation: adjustedLocation)
      pitch = pitchFromBarLineIndex(barLineIndex)
      noteValue = staffViewModel.currentNoteValue
      beatLocation = beatLocationFrom(location: adjustedLocation)
      
      InsertNote(note: OpusNote(pitch: pitch, beatLocation: beatLocation, noteValue: noteValue),
        location: adjustedLocation,
        invoker: self,
        target: self.staffViewModel).run()
    }
  }

  func twoFingerSingleTap(gestureRecognizer: UITapGestureRecognizer) {
    
    let midpointLocation =
      gestureRecognizer.locationInView(self.staffEditorScrollView!)
    println(midpointLocation)
    
    let touch1Location =
      gestureRecognizer.locationOfTouch(0, inView: self.staffEditorScrollView!)
    let touch2Location =
      gestureRecognizer.locationOfTouch(1, inView: self.staffEditorScrollView!)
    
    if twoTouchesAreAdjacent(touchOne: touch1Location,
      touchTwo: touch2Location) {
        println("we're doing something!")
        let adjustedLocation = closestValidPositionFrom(location: midpointLocation)
        selectNoteAt(adjustedLocation)
        
        if selectedNote == nil {
          println("selected is nil")
          // important: not at adjusted, but actual touch location!
          DisplayNoteSelectionMenu(invoker: self, target: self.container, location: midpointLocation).run()
        } else {
          println("selected is not nil")
          DisplayAccidentalMenu(note: selectedNote!, invoker: self).run()
        }
    }
  }
  
  func oneFingerDrag(gestureRecognizer: UIPanGestureRecognizer) {
    
    switch gestureRecognizer.state {
      
    case UIGestureRecognizerState.Began:
      selectNoteAt(gestureRecognizer.locationInView(self.staffEditorScrollView!))
      

    case UIGestureRecognizerState.Changed:
      if selectedNote != nil {
        
        let mouseLocation = gestureRecognizer.locationInView(self.staffEditorScrollView!)
        
        let currentLocation = selectedNote!.location
        
        let adjustedLocation = closestValidPositionFrom(location: mouseLocation)
        
        if adjustedLocation != currentLocation { // note has visually moved. reset translation.
          gestureRecognizer.setTranslation(CGPointZero, inView: self.staffEditorScrollView!)
          selectedNote!.updateLocation(adjustedLocation)
        }
        
        
      }
      
    case UIGestureRecognizerState.Ended:
      if selectedNote != nil {
        
        let location = selectedNote!.location
        let adjustedLocation = closestValidPositionFrom(location: location)
        
        let barLineIndex = barLineIndexFrom(adjustedLocation: adjustedLocation)
        let pitch = pitchFromBarLineIndex(barLineIndex)
        let noteValue = staffViewModel.currentNoteValue
        let beatLocation = beatLocationFrom(location: adjustedLocation)
        
        UpdateNote(oldNote: selectedNote!.note!,
          newNote: OpusNote(pitch: pitch, beatLocation: beatLocation, noteValue: noteValue),
          invoker: self,
          target: self.staffViewModel)
        
        selectedNote = nil
      }
      
      
    default:
      println("")
      
    }
  }
  
  func twoFingerDrag(gestureRecognizer: UIPanGestureRecognizer) {

  }
  
  //MARK: - Graphics Helper Functions
  //TODO: - Should these be in their own class?
  
  func displayNewNote(note: UINote) {
    notes.insert(note)
    note.imageView.frame = CGRectMake(note.location.x, note.location.y, note.size.width, note.size.height)
    note.updateLocation(note.location)
    self.staffEditorScrollView!.addSubview(note.imageView)
  }
  
  func removeExistingNote(note: UINote){
    notes.remove(note)
    // TODO: - Handle graphics of removing note?
  }
  
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
  
  //      Gives vertical and horizontal grid locked coordinate
  func closestValidPositionFrom(#location: CGPoint) -> CGPoint {
    var returnX: Int = Int(location.x) + (Opus.BUCKET_WIDTH / 2)
    var returnY: Int = 0
    returnX /= Opus.BUCKET_WIDTH
    returnX *= Opus.BUCKET_WIDTH
    
    if returnX < Opus.BUCKET_WIDTH {
      returnX = Opus.BUCKET_WIDTH // So we don't go off the edge.
    }
    
    for index in 0...verticalSpaces.count - 1 {
      if (location.y) <= CGFloat(verticalSpaces[index]) + CGFloat(10) { // adding a vertical note cushion! Abstract later.
        returnY = Int(verticalSpaces[index])
        return CGPoint(x: CGFloat(returnX), y: CGFloat(verticalSpaces[index]))
      }
    }
    return CGPoint(x: CGFloat(returnX), y: CGFloat(verticalSpaces[verticalSpaces.count-1]))
    
  }
  
  func elongateStaff(){
    staffEditorScrollView!.contentSize.width += elongationConstant
    staffImageView.frame.size.width += elongationConstant
  }
  
  
  func updatePosition(x_ratio: CGFloat){
    var updatedPosition = x_ratio * staffEditorScrollView!.contentSize.width
    if updatedPosition < 0{
      staffEditorScrollView!.contentOffset = CGPointMake(0, 0)
    }else{
      staffEditorScrollView!.contentOffset = CGPointMake(updatedPosition, 0)
    }
  }
  
  
  
  
  func pitchFromBarLineIndex(barLineIndex: Int) -> Pitch {
    // replace this with current harmonic
    let key = Scale.Major

    // replace this with current key
    let cMajor = key(Pitch(chroma: Chroma.C, octave: 1))

    let trebleClefNotes = ClefKey.pitchesForScaleOnClef(scale: cMajor, clef: .Treble)
    
    return trebleClefNotes[barLineIndex]
  }
  
  func barLineIndexFrom(#adjustedLocation: CGPoint) -> Int {
    let myY = Float(adjustedLocation.y)
    //println(adjustedLocation)
    for index in 0...verticalSpaces.count - 1 {
      if myY == verticalSpaces[index] {
        //println(verticalSpaces)
        //println("returning \(index) for \(verticalSpaces[index]) = \(myY)")
        return index
      }
    }
    return 0
  }

  
  func beatLocationFrom(#location: CGPoint) -> MusicTimeStamp {
    let adjustedLocation = closestValidPositionFrom(location: location)
    var myBucket: Int = Int(location.x) / Opus.BUCKET_WIDTH
    
    return Float64(myBucket)
    
  }

  
  //MARK: - UIScrollViewDelegate
  
  //MARK: - Drawing To Staff
  
  //MARK: - Presenting Modular Popover Menus
  
  
  func presentAccidentalMenuOnNote(note: UINote) {
    var contentViewController = PopoverAccidentalMenuViewController(nibName: "PopoverAccidentalMenuViewController", bundle: nil)
    var popController = UIPopoverController(contentViewController: contentViewController)
    let frame = note.imageView.frame
    
    let targetView = self.view
    
    popController.popoverContentSize = CGSize(width: frame.width, height: frame.height)
    popController.presentPopoverFromRect(frame, inView: targetView, permittedArrowDirections: UIPopoverArrowDirection.Right, animated: true)
  }
  
  func presentNoteValueSelectionMenuAt(#location: CGPoint) {
    let contentViewController: NoteValueSelectionViewController = NoteValueSelectionViewController(currentSeg: currentSegControlIndex, currentSubSeg: currentSubSegControlIndex)
    let targetRect = CGRectMake(location.x, location.y, 1, 1)
    
    var popoverController = UIPopoverController(contentViewController: contentViewController)
    
    popoverController.presentPopoverFromRect(targetRect, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.allZeros, animated: true)
    
  }

  func setNoteValueMenuSelectedItem(segControlIndex: Int, subIndex: Int){
    currentSegControlIndex = segControlIndex
    currentSubSegControlIndex = subIndex
  }

}
