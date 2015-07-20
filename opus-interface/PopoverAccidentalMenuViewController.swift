//
//  PopoverAccidentalMenuViewController.swift
//  opus-interface
//
//  Created by Nick DeMarco on 7/7/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class PopoverAccidentalMenuViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func sharpButtonPressed(sender: AnyObject) {
    //println("Sharp selected")
    // TODO: send command to sharp current note
  }

  @IBAction func flatButtonPressed(sender: AnyObject) {
    //println("Flat selected")
    // TODO: send command to flat current note
  }
}
