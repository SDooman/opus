//
//  LaunchViewController.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/16/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit
import MusicKit

class LaunchViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let major = Scale.Major
      let cMajor = major(Pitch(chroma: Chroma.C, octave: 1)) // Octave is arbitrary, checking on treble clef only.
      println(Opus.pitchesForScaleOnTrebleClef(scale: cMajor, clef: .Treble))


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
