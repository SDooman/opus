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
    override var description: String {get {return self.updateDescription()}} // Overwriting println return
 
    let sensitivity = CGFloat(20.0)    // how wide around note's center will a click = note selection
    var touchingNow:Bool = false       // used in touches Moved method
    var noteArray: [UINote] = [UINote]()
    var currentNote: UINote?
 
    // Waiting to implement SideBar functionality - commented out for now
    //var sideBar = SideBar()
    //let noteValues = ["Whole Note", "Half Note", "Quarter Note", "Eighth Note", "Sixteenth Note"]
    
    var selectedValue = UINote(value: .Quarter).value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupStaff()
        createClearMeasureButton()
    
        /*
        // SideBar Code Elided
        sideBar = SideBar(sourceView: self.view, menuItems: noteValues)
        sideBar.delegate = self
        */
    
        // Do any additional setup after loading the view.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (event.allTouches()!.count != 1){
            return
        }
        var touch: UITouch = touches.first as! UITouch
        var location = touch.locationInView(self.view)
    
        if location.y < 300 && location.y > 50{
            for note in noteArray {
                if isTouchingNote(note, location: location) && locationIsOnStaff(location){
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
        newNote.imageView?.frame = CGRect(origin: location, size: newNote.image!.size)
        newNote.setLocation(location) // redundancy here because setLocation adjusts for each note's individual sizes
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
    
 
    /*
    // Sidebar code elided for now
    func sideBarDidSelectButtonAtIndex(index: Int) {
        switch index {
            case 0:
                selectedValue = Note(value: .Whole).value
            case 1:
                selectedValue = Note(value: .Half).value
            case 2:
                selectedValue = Note(value: .Quarter).value
            case 3:
                selectedValue = Note(value: .Eighth).value
            case 4:
                selectedValue = Note(value: .Sixteenth).value
            default:
                selectedValue = Note(value: .Quarter).value
        }
    }
    */
 
 
    func locationIsOnStaff(location: CGPoint) -> Bool{
        let clickX = Double(location.x)
        let lowerLim = Double(staffImage.frame.minX) + 120 // to create space for key/time signature
        let upperLim = Double(staffImage.frame.maxX) // -40 at one point - before adding the trailing staff
    
        return clickX >= lowerLim && clickX <= upperLim
    }
 
 
    func setupStaff() {
    
        let imageName = _staffImageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 200, 600, 200)
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
    
    // ignore this for now.
    func updateDescription() -> String {
        if noteArray.count == 0  {
            // return empty thing
        }
        var toReturnArray: [String] = []
        var toReturn: String = ""
        self.sortNoteArray()
        for index in 0...noteArray.count-1{
            let noteIndex: String = String(index)
            let noteValue: String = noteArray[index].value!.description
            let noteVertical: String = String(noteArray[index].vertIndex!)
            toReturnArray.append("Index: \(noteIndex), Beat Value: \(noteValue), VertIndex: \(noteVertical) \n")
            
        }
        for subString in toReturnArray {
            toReturn += subString
        }
        return toReturn
    }
 
    /*
    // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
 
}
