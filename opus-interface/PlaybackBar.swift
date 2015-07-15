//
//  playbackBar.swift
//  opus-interface
//
//  Created by Peter Bowden on 7/15/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

@IBDesignable class PlaybackBar: UIView {
  
  let nibName: String = "PlaybackBar"
  var view: UIView!

  @IBOutlet weak var stop_button: UIButton!
  @IBOutlet weak var play_pause_button: UIButton!
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUp()
  }
  
  func setUp(){
    view = loadViewFromNib()
    
    view.frame = bounds
    view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    
    self.addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib: UINib = UINib(nibName: nibName, bundle: bundle)
    let tempView = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    return tempView
  }
  
  @IBAction func stop_pressed() {
  }
  
  @IBAction func play_pause_pressed() {
    
    if play_pause_button.selected{
      play_pause_button.selected = false
    }else{
      play_pause_button.selected = true
    }
  }

}
