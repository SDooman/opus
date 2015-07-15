//
//  StaffNavigationScrollView.swift
//  opus-interface
//
//  Created by Peter Bowden on 7/9/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class StaffNavigationScrollView: UIScrollView {
  
  private var owningVC: StaffNavigationViewController!
  private var owningVCParent: StaffContainerViewController!
  
  init(size: CGSize, owner: UIViewController){
    super.init(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: size))
    owningVC = owner as! StaffNavigationViewController
    owningVCParent = owningVC!.parentViewController as! StaffContainerViewController
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if self.dragging{
      owningVCParent.updateStaffEditorView((contentOffset.x + owningVC!.contentInsetConstant)/contentSize.width)
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    let touch = touches.first as! UITouch
    println(touch.locationInView(self))
    owningVC.makeNote(touch.locationInView(self))
  }
  
  func takeSnapshot() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.mainScreen().scale)
    
    drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
