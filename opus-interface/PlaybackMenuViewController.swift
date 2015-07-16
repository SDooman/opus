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
    
    createPlayPauseButton()
    createStopButton()
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
  
  func createPlayPauseButton(){
    play_pause_button = UIButton()
    play_pause_button.adjustsImageWhenHighlighted = false
    play_pause_button.frame = CGRectMake((menu_frame.width/2) + menu_frame.width/2-button_width-(menu_frame.width/2-button_width)/2, (menu_frame.height-button_height)/2, button_width, button_height)
    
    let play_button_image = UIImage(named: "play-button")
    let pause_button_image = UIImage(named: "pause-button")
    play_pause_button.setImage(play_button_image, forState: UIControlState.Normal)
    play_pause_button.setImage(pause_button_image, forState: UIControlState.Highlighted)
    play_pause_button.setImage(pause_button_image, forState: UIControlState.Selected)
    
    play_pause_button.addTarget(self, action: "playPauseButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
    
    self.view.addSubview(play_pause_button)
  }
  
  func createStopButton(){
    stop_button = UIButton()
    stop_button.adjustsImageWhenHighlighted = false
    stop_button.frame = CGRectMake(menu_frame.width/2-button_width-(menu_frame.width/2-button_width)/2, (menu_frame.height-button_height)/2, button_width, button_height)
    
    let stop_button_image = UIImage(named: "stop-button")
    let stop_button_pressed_image = UIImage(named: "stop-button-highlighted")
    stop_button.setImage(stop_button_image, forState: UIControlState.Normal)
    stop_button.setImage(stop_button_pressed_image, forState: UIControlState.Highlighted)
    
    stop_button.addTarget(self, action: "stopButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
    
    self.view.addSubview(stop_button)
  }
  
  func playPauseButtonClicked(sender: UIButton!){
    
    if play_pause_button.selected{
      play_pause_button.selected = false
    }else{
      play_pause_button.selected = true
    }
  }
  
  func stopButtonClicked(sender: UIButton!){
  }

  func playBackHasStopped(){
    play_pause_button.selected = false
  }
  
  
}
