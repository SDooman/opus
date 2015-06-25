//
//  MeasureViewController.swift
//  opus_organization_test
//
//  Created by Nick DeMarco on 6/12/15.
//  Copyright (c) 2015 Nick DeMarco. All rights reserved.
//

import UIKit

class MeasureViewController: UIViewController, UIGestureRecognizerDelegate, Printable {
 
    @IBOutlet weak var staffImage: UIImageView!
    let _staffImageName = "Music-staff"
 
    let sensitivity = CGFloat(40.0)    // how wide around note's center will a click = note selection
    var noteArray: [UINote] = [UINote]()
    var currentNote: UINote?
    var selectedValue = UINote(value: .Quarter).value
    var startingOnNote:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupStaff()
        self.createClearMeasureButton()
        self.setupGestureRecognizers()

    }
    
    func twoFingerSingleTap(gestureRecognizer: UITapGestureRecognizer){
        let location = gestureRecognizer.locationInView(self.view)
        let touch1Location = gestureRecognizer.locationOfTouch(0, inView: self.view)
        let touch2Location = gestureRecognizer.locationOfTouch(1, inView: self.view)
        
        if self.twoTouchesAreAdjacent(touch1Location, location2: touch2Location){
            for note in noteArray {
                if isTouchingNote(note, location: location) && locationIsOnStaff(location){
                    self.showMenuOnNote(note)
                    return
                }
            }
            self.showFloatingMenuAtPoint(location)
        }
    }
    
    func twoTouchesAreAdjacent(location1: CGPoint, location2: CGPoint) -> Bool {
        let distance = pow((location1.x - location2.x), 2) + pow((location1.y - location2.y), 2)
        return sqrt(distance) < 60.0
    }
    
    func dragGesture(gestureRecognizer: UIPanGestureRecognizer){
        let location = gestureRecognizer.locationInView(self.view)

        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            for note in noteArray {
                if isTouchingNote(note, location: location) && locationIsOnStaff(location){
                    currentNote = note
                    return
                }
            }
        }

        if currentNote == nil && !self.startingOnNote{
            let dummyNote = UINote(value: selectedValue!)
            currentNote = createNote(location)
        }
        else if currentNote != nil {
            var translation = gestureRecognizer.translationInView(self.view)
            let currentLocation = currentNote!.myLocation
            
            let newX: CGFloat = (translation.x + currentLocation!.x)
            let newY: CGFloat = (translation.y + currentLocation!.y)
            
            let newLocation = CGPoint(x: newX, y: newY)
            gestureRecognizer.setTranslation(CGPointZero, inView: self.view)
            currentNote!.setLocation(newLocation)
        }
        
        if(gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            currentNote = nil
            self.startingOnNote = false
            return
        }
    }
    
    func singleTap(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.locationInView(self.view)
        for note in noteArray {
            if isTouchingNote(note, location: location) && locationIsOnStaff(location){
                currentNote = note
                currentNote?.setLocation(location)
                break
            }
        }
        if currentNote == nil && locationIsOnStaff(location){
            let dummyNote = UINote(value: selectedValue!)
            createNote(location)
        }
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended){
            currentNote = nil
            self.startingOnNote = false
        }
    }
    
    func doubleTap(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.locationInView(self.view)
        for note in noteArray {
            if isTouchingNote(note, location: location) && locationIsOnStaff(location){
                self.showMenuOnNote(note)
                break
            }
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMenuOnNote(uiNote: UINote) {
        var popView = NoteSelectedPopViewController(nibName: "NoteSelectedPopView", bundle: nil, measureView: self)
        var popController = UIPopoverController(contentViewController: popView)
        let myWidth = uiNote.imageView?.frame.width
        let myHeight = uiNote.imageView?.frame.height
        let myFrame = uiNote.imageView?.frame
        
        // well doesn't this look gross? This is my current solution to a non-fatal error message I got when I started working with the popover view controller. "Presenting view controllers on detached view controllers is discouraged." It has to do with our storyboard - because we're doing most of the views programmatically, the Storyboard actually sees this VC - the measure view controller, as detached from the storyboard. So, the measure view controller is "detached." The following code makes the actual target VC the Staff View Controller.
        let targetVC = self.view.superview!.superview!.superview!
        
        popController.popoverContentSize = CGSize(width: myWidth!, height: myHeight!)
        popController.presentPopoverFromRect((uiNote.imageView?.frame)!, inView: targetVC, permittedArrowDirections: UIPopoverArrowDirection.Right, animated: true)
        
        // need to set current note to passed parameter uiNote to sharp/flat it
        
    }
    
    func showFloatingMenuAtPoint(location: CGPoint) {
        var popView = FloatingMenuPopViewController(nibName: "FloatingMenuPopView", bundle: nil, measureView:self)
        var popController = UIPopoverController(contentViewController: popView)
        let myWidth: CGFloat = 100.0
        let myHeight: CGFloat = 200.0
        let myFrame = CGRectMake(location.x, location.y, myWidth, myHeight)
        
        let targetVC = self.view.superview!.superview!.superview!
        popController.popoverContentSize = CGSize(width: myWidth, height: myHeight)
        popController.presentPopoverFromRect(myFrame, inView: targetVC, permittedArrowDirections: UIPopoverArrowDirection.allZeros, animated: true)
    }
    
    // should we be passing strings here, or some sort of enum?
    func notifyMeasureViewAccidentalSelected(selectedAccidental: String) {
        switch selectedAccidental {
        case "sharp":
            // make current note sharp
            println("Note Sharped!")
        case "natural":
            // make current note natural
            println("Note Naturaled!")
        case "flat":
            // make current note flat
            println("Note Flatted!")
        default:
            return
        }
        
        // need to set current note to nil after sharping or flatting it
    }

    func isTouchingNote(note: UINote, location: CGPoint) -> Bool {
        let noteX = note.getNoteCenter().x
        let noteY = note.getNoteCenter().y
        let touchX = location.x
        let touchY = location.y
        var withinX = false
        var withinY = false
    
        if touchX >= noteX - sensitivity && touchX <= noteX + sensitivity {
            withinX = true
        }
        if touchY >= noteY - sensitivity && touchY <= noteY + sensitivity {
            withinY = true
        }
        return withinX && withinY
    }
 
    func createNote(location: CGPoint) -> UINote{
        let newNote = UINote(value: selectedValue!)
        newNote.imageView?.frame = CGRect(origin: location, size: newNote.mySize!)
        newNote.setLocation(location)
        view.addSubview(newNote.imageView!)
        noteArray.append(newNote)
        return newNote
    }
    
    func sortNoteArray() {
        let sortedArray:[UINote] = sorted(noteArray, {
            (note1: UINote, note2: UINote) -> Bool in
            return note1.imageView?.center.x > note2.imageView?.center.x
        })
        noteArray = sortedArray
    }
    
    func locationIsOnStaff(location: CGPoint) -> Bool{
        return CGRectContainsPoint(staffImage.frame, location)
    }
 
    func setupStaff() {
        let imageName = _staffImageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        let screenBounds = UIScreen.mainScreen().bounds
        imageView.frame = screenBounds

        view.addSubview(imageView)
    
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        staffImage = imageView
        
        // BUG: Some staff images go to the edge of the screen / frame, others do not.
    
        var constY = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        view.addConstraint(constY)
    
        var constA = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        view.addConstraint(constA)
    
        var constB = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        view.addConstraint(constB)

        var constC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0)
        view.addConstraint(constC)
        
    }
    
    func setupGestureRecognizers() {
        let singleSelector: Selector = "singleTap:"
        var singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: singleSelector)
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        self.view.addGestureRecognizer(singleTap)
        
        let twoFingerSingleTapSelector: Selector = "twoFingerSingleTap:"
        var twoFingerSingleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: twoFingerSingleTapSelector)
        twoFingerSingleTap.numberOfTouchesRequired = 2
        twoFingerSingleTap.delegate = self
        self.view.addGestureRecognizer(twoFingerSingleTap)
        
        let doubleSelector: Selector = "doubleTap:"
        var doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: doubleSelector)
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        self.view.addGestureRecognizer(doubleTap)
        
        let dragSelector: Selector = "dragGesture:"
        var dragRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: dragSelector)
        dragRecognizer.minimumNumberOfTouches = 1
        dragRecognizer.maximumNumberOfTouches = 1
        dragRecognizer.delegate = self
        
        self.view.addGestureRecognizer(dragRecognizer)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInView(self.view)
        for note in noteArray {
            if self.isTouchingNote(note, location: location){
                self.startingOnNote = true
                return
            }
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.startingOnNote = false
    }
    
    func createClearMeasureButton() {
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(100,250, 100, 50)
        button.backgroundColor = UIColor.blackColor()
        button.setTitle("Clear Measure", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "clearMeasure", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.center = CGPointMake(100, 250)
        self.view.addSubview(button)
    }
    
    func clearMeasure() {
        for note in noteArray {
            note.imageView?.removeFromSuperview()
        }
        noteArray = [UINote]()
    }
    

 
}
