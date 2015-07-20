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
    
    var gestureRecognizers = self.gestureRecognizers as! [UIGestureRecognizer]
    for gesture in gestureRecognizers {
      if let panGesture = gesture as? UIPanGestureRecognizer{
        panGesture.maximumNumberOfTouches = 2
        panGesture.minimumNumberOfTouches = 2
      }
    }
    
    
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
      UpdateStaffNavigatorPosition(x_ratio: contentOffset.x/contentSize.width, target: owningVCParent.staffNavigator).run()
      
      if contentSize.width-contentOffset.x < Opus.EDITOR_WIDTH{
        ElongateStaff(invoker: owningVC, target: owningVCParent.staffNavigator).run()
      }
    }
  }
  
  func takeSnapshot() -> UIImage{
    
    UIGraphicsBeginImageContext(CGSizeMake(contentSize.width, frame.height))
    
    var savedContentOffset = contentOffset
    var savedFrame = frame
    
    contentOffset = CGPointZero
    frame = CGRectMake(0, 0, contentSize.width, frame.height)
    layer.renderInContext(UIGraphicsGetCurrentContext())
    var image = UIGraphicsGetImageFromCurrentImageContext()
    
    contentOffset = savedContentOffset
    frame = savedFrame
    
    UIGraphicsEndImageContext()
    
    //println(contentSize.width)
    
    return image
    
  }
}