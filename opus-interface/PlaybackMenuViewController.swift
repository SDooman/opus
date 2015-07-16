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
  
  var play_pause_button: UIButton!
  var stop_button: UIButton!
  let button_width: CGFloat = 80
  let button_height: CGFloat = 80
  let menu_frame = CGRect(x: 15, y: Opus.SCREEN_HEIGHT-100, width: 200, height: 85)
  
  var container : StaffContainerViewController {
    
    return parentViewController as! StaffContainerViewController
  }
  
  var staffViewModel : StaffViewModel {
    return container.staffViewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.frame = menu_frame
    
    create_play_pause_button()
    create_stop_button()
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
  
  func create_play_pause_button(){
    play_pause_button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    play_pause_button.frame = CGRectMake((menu_frame.width-button_width)/2, (menu_frame.height-button_height)/2, button_width, button_height)
    let play_button_image = UIImage(named: "play-button")
    let pause_button_image = UIImage(named: "pause-button")
    play_pause_button.setImage(play_button_image, forState: UIControlState.Normal)
    play_pause_button.setImage(pause_button_image, forState: UIControlState.Selected)
    play_pause_button.addTarget(self, action: "clearMeasure", forControlEvents: UIControlEvents.TouchUpInside)
  
    self.view.addSubview(play_pause_button)
  }
  
  func create_stop_button(){
    stop_button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    stop_button.frame = CGRectMake(menu_frame.width-button_width-((menu_frame.width-button_width)/2), (menu_frame.height-button_height)/2, button_width, button_height)
    let stop_button_image = UIImage(named: "stop-button")
    let stop_button_pressed = UIImage(named: "stop-button-highlighted")
    stop_button.setImage(stop_button_image, forState: UIControlState.Normal)
    stop_button.addTarget(self, action: "clearMeasure", forControlEvents: UIControlEvents.TouchUpInside)
    
    self.view.addSubview(stop_button)
  }
  
 
  
  
  
  
}
