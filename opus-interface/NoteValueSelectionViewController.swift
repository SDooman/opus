//
//  NoteValueSelectionViewController.swift
//  modal_note_value2
//
//  Created by Nick DeMarco on 7/6/15.
//  Copyright (c) 2015 Nick DeMarco. All rights reserved.
//

import UIKit

class NoteValueSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Don't forget to add these images to xcassets!
    let noteImageNames: [String] = ["menu_whole_note", "menu_half_note", "menu_quarter_note", "menu_eighth_note", "menu_sixteenth_note"]
    let restImageNames: [String] = ["menu_whole_rest", "menu_half_rest", "menu_quarter_rest", "menu_eighth_rest", "menu_sixteenth_rest"]
    var tableView: UITableView!
    var popoverView: UIView!
    let contentSize: CGSize = CGSizeMake(320, 320)  // how big the popup is.
    
    let initialSegIndex: Int!                       // index of previously-selected segment controller
    let initialSubSegIndex: Int!                    // 0/1 whether note or rest of that seg was selected
    
    var container : StaffEditorViewController {
        let pres = presentingViewController as! StaffContainerViewController
        return pres.staffEditor
    }
    
    init(currentSeg: Int, currentSubSeg: Int) {
        popoverView = UIView(frame: CGRectMake(0, 0, contentSize.width, contentSize.height))
        popoverView.backgroundColor = UIColor.redColor()
        
        tableView = UITableView(frame: popoverView.bounds, style: UITableViewStyle.Plain)
        tableView.rowHeight = 64
        
        popoverView.addSubview(tableView)
        
        popoverView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        tableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        //Rotate TableView
        let oldFrame = tableView.frame
        tableView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        tableView.frame = oldFrame
        
        tableView.allowsSelection = false
        
        initialSegIndex = currentSeg
        initialSubSegIndex = currentSubSeg
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view = popoverView
        self.preferredContentSize = contentSize
        
        // register custom cell:
        var nib = UINib(nibName: "NoteValueSelectionTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        

    }
    
    func setInitialSelectionActive() {
        if initialSegIndex != -1 && initialSubSegIndex != -1 { // if this is past first instance
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: initialSegIndex, inSection: 0)) as! NoteValueSelectionTableViewCell
            let mySeg = cell.beatRestSegment
            mySeg.selectedSegmentIndex = initialSubSegIndex
        }
    }
    
    // MARK: DataSource Methods
    
    //NUMBER OF ROWS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.noteImageNames.count
    }
    
    //CELL @ INDEX
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: NoteValueSelectionTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! NoteValueSelectionTableViewCell
        
        return cell
    }
    
    // WILL DISPLAY CELL - for formatting and highlighting previously selected cell.
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let myCell = cell as! NoteValueSelectionTableViewCell
        
        formatCell(myCell, index: indexPath.item)
        
        if indexPath.item == self.initialSegIndex {
            myCell.beatRestSegment.selectedSegmentIndex = initialSubSegIndex
        }
    }
    
    // setting images from array and adding constraints.
    func formatCell(cell: NoteValueSelectionTableViewCell, index: Int) {
        // add images based on index
        // the table view is rotated right so the rightmost is index 0, left is 4.
        let arrayIndex = 4 - index
        let noteImage = UIImage(named: noteImageNames[arrayIndex])
        let restImage = UIImage(named: restImageNames[arrayIndex])
        
        cell.beatRestSegment.setImage(noteImage, forSegmentAtIndex: 0)
        cell.beatRestSegment.setImage(restImage, forSegmentAtIndex: 1)
        
        //Adding constraints
        
        cell.beatRestSegment.addConstraint(
            NSLayoutConstraint(
                item: cell.beatRestSegment,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: self.tableView.rowHeight
            )
        )
        
        cell.beatRestSegment.addConstraint(
            NSLayoutConstraint(
                item: cell.beatRestSegment,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.LessThanOrEqual,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: contentSize.width
            )
        )
        
        // add selector / "Action listener"
        let mySelector: Selector = "handleSelection:"
        cell.beatRestSegment.addTarget(self, action: mySelector, forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: "delegate" methods for segmented control
    func handleSelection(sender: UISegmentedControl) {
        for index in 0...self.noteImageNames.count - 1 {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! NoteValueSelectionTableViewCell
            
            let mySeg = cell.beatRestSegment as UISegmentedControl
            
            if mySeg !== sender {
                mySeg.selectedSegmentIndex = -1 // deselect all other segmented controls
            } else {
                let newValue = self.opusNoteValueFrom(firstIndex: index, secondIndex: mySeg.selectedSegmentIndex)
              let command = UpdateNoteSelectionMenuValue(segIndex: index, subSegIndex: mySeg.selectedSegmentIndex, target: container, newValue: newValue)
                command.run()
            }
        }
    // comment this out to require the user to click away from menu to dismiss it. 
    self.dismissViewControllerAnimated(true, completion: nil)
    }
  
  func opusNoteValueFrom(#firstIndex: Int, secondIndex: Int) -> OpusNoteValue {
    
    if secondIndex == 0 {
      switch firstIndex {
      case 0:
        println("Sixteenth Note")
        return OpusNoteValue.Sixteenth
      case 1:
        println("Eighth Note")
        return OpusNoteValue.Eighth
      case 2:
        println("Quarter Note")
        return OpusNoteValue.Quarter
      case 3:
        println("Half Note")
        return OpusNoteValue.Half
      case 4:
        println("Whole Note")
        return OpusNoteValue.Whole
      default:
        println("default")
        return OpusNoteValue.Quarter
      }
    } else if secondIndex == 1 {
      switch firstIndex {
      case 0:
        println("Sixteenth Rest")
      case 1:
        println("Eighth Rest")
      case 2:
        println("Quarter Rest")
      case 3:
        println("Half Rest")
      case 4:
        println("Whole Rest")
      default:
        println("default")
      }
    }
      return OpusNoteValue.DottedQuarter
  }

}
