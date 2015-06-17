//
//  PlaybackMenuViewController.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/30/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class PlaybackMenuViewController: UIViewController {
  
  //MARK: - Properties
  
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

}
