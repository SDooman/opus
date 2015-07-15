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
  
  @IBOutlet weak var play_pause_button: UIButton!
  
  var container : StaffContainerViewController {
    
    return parentViewController as! StaffContainerViewController
  }
  
  var staffViewModel : StaffViewModel {
    return container.staffViewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.frame = CGRect(x: 15, y: Opus.SCREEN_HEIGHT-100, width: 200, height: 85)
  }

  @IBAction func stop_button_pressed() {
  }
  
  @IBAction func play_pause_button_pressed() {
    
    if play_pause_button.selected{
      play_pause_button.selected = false
    }else{
      play_pause_button.selected = true
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
    
  }
}
