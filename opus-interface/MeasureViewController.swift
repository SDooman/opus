//
//  MeasureViewController.swift
//  opus_organization_test
//
//  Created by Nick DeMarco on 6/12/15.
//  Copyright (c) 2015 Nick DeMarco. All rights reserved.
//

import UIKit

class MeasureViewController: UIViewController, Printable {
 
    @IBOutlet weak var staffImage: UIImageView!
    let _staffImageName = "Music-staff"
 
    let sensitivity = CGFloat(20.0)    // how wide around note's center will a click = note selection
    var touchingNow:Bool = false       // used in touches Moved method
    var noteArray: [UINote] = [UINote]()
    var currentNote: UINote?
    var selectedValue = UINote(value: .Quarter).value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupStaff()
        createClearMeasureButton()

    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        // BUG: Staff images go over the edge of the View, causing there to be an 
        // "overlap" at the connection between Measure VCs.
        
        var constY = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        view.addConstraint(constY)
        
        var constA = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        view.addConstraint(constA)
        
        var constB = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        view.addConstraint(constB)
        
        var constC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview!, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0)
        view.addConstraint(constC)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (event.allTouches()!.count != 1){
            return
        }
        
        var touch: UITouch = touches.first as! UITouch
        var location = touch.locationInView(self.view)
        
        if location.y < 30000 && location.y > 0{ // formerly 300 and 50
            for note in noteArray {
                if isTouchingNote(note, location: location) && locationIsOnStaff(location){
                    
                    if touch.tapCount == 2{
                        self.showMenuOnNote(note)
                        return
                    }
                    
                    currentNote = note
                    touchingNow = true
                    currentNote?.setLocation(location)
                    break // first one found is the note. Good?
                }
            }
            if currentNote == nil && locationIsOnStaff(location) {
                let dummyNote = UINote(value: selectedValue!)
                createNote(location)
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (event.allTouches()!.count != 1){
            return
        }
        var touch: UITouch = touches.first as! UITouch
        var location = touch.locationInView(self.view)
        
        if touchingNow && locationIsOnStaff(location){
            currentNote!.setLocation(location)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        touchingNow = false
        currentNote = nil
    }
    
    func createNote(location: CGPoint) -> UINote{
        let newNote = UINote(value: selectedValue!)
        newNote.imageView?.frame = CGRect(origin: location, size: newNote.mySize!)
        newNote.setLocation(location) // redundancy here because setLocation adjusts for each note's individual sizes
        view.addSubview(newNote.imageView!)
        noteArray.append(newNote)
        return newNote
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
        
        // need to set current note to passed parameter uiNote
        
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
        
        // need to set current note to nil
    }
    
    func sortNoteArray() {
        let sortedArray:[UINote] = sorted(noteArray, {
            (note1: UINote, note2: UINote) -> Bool in
            return note1.imageView?.center.x > note2.imageView?.center.x
        })
        noteArray = sortedArray
    }
 
    func locationIsOnStaff(location: CGPoint) -> Bool{
        let clickX = Double(location.x)
        let lowerLim = Double(staffImage.frame.minX) + 20 // to create space for key/time signature
        let upperLim = Double(staffImage.frame.maxX) // -40 at one point - before adding the trailing staff
    
        return clickX >= lowerLim && clickX <= upperLim
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
