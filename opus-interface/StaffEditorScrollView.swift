//
//  StaffEditorScrollView.swift
//  opus-interface
//
//  Created by Peter Bowden on 7/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class StaffEditorScrollView: UIScrollView {
  
  private var owningVC: StaffEditorViewController!
  private var owningVCParent: StaffContainerViewController!
  
  init(size: CGSize, owner: UIViewController){
    super.init(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: size))
    owningVC = owner as! StaffEditorViewController
    owningVCParent = owningVC.parentViewController as! StaffContainerViewController
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    //TODO: replace this with UIRefreshControl functionality described below
    /*
    NOTE: Implement a UIRefreshControl that, when you pull to the right, add a variable number of staffs.
    IE: Pull a little to the left, see a '1' appear inside the refresh control
    Keep pulling to the left to change the number to '2', etc - release to add that many staffs.
    */
    
    if contentSize.width-contentOffset.x == Opus.EDITOR_WIDTH{
      contentOffset.x = contentSize.width-(Opus.EDITOR_WIDTH-1)
    }
    
    if self.dragging{
      owningVCParent.updateStaffNavigationView(contentOffset.x/contentSize.width)
      
      if contentSize.width-contentOffset.x < Opus.EDITOR_WIDTH{
        owningVCParent.elongateStaff()
      }
    }
  }
}