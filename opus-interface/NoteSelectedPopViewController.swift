//
//  NoteSelectedPopViewController.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/19/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class NoteSelectedPopViewController: UIViewController {
    
    var myMeasureViewController: MeasureViewController?
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, measureView: MeasureViewController) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        myMeasureViewController = measureView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func sharpSelected(sender: AnyObject) {
        //println("Sharp Clicked!")
        myMeasureViewController?.notifyMeasureViewAccidentalSelected("sharp")
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func flatSelected(sender: AnyObject) {
        //println("Flat Clicked!")
        myMeasureViewController?.notifyMeasureViewAccidentalSelected("flat")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // do fancy things
}
    