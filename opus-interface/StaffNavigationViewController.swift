//
//  StaffNavigationViewController.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/29/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class StaffNavigationViewController: UIViewController, UIScrollViewDelegate {
  
  //MARK: - Constants:
  
  let numberOfStartingMeasures: Int = 2
  let elongationConstant: CGFloat
  let initialStaffWidth: CGFloat
  let contentInsetConstant: CGFloat
  let initialImageViewFrame: CGRect
  let squareViewFrame: CGRect
  let locationIndicatorSquare = UIView()
  let viewControllerFrame: CGRect
  var notes: Set<UINote> = []
  var imageViews: Array<UIImageView> = []
  var currentIndex: Int = 0
  var frameYOffset: CGFloat = -25
  
  //MARK: - Properties
  
  var staffNavigationScrollView: StaffNavigationScrollView?

  var container : StaffContainerViewController {
    
    return parentViewController as! StaffContainerViewController
  }
  
  var staffViewModel : StaffViewModel {
    return container.staffViewModel
  }
  
  //MARK: - Lifecycle
  
  init() {
    //viewControllerFrame = CGRect(x: 0, y: Opus.SCREEN_HEIGHT * 0.05, width: Opus.NAVIGATION_WIDTH, height: Opus.NAVIGATION_HEIGHT)
    viewControllerFrame = CGRect(x: 0, y: Opus.SCREEN_HEIGHT * 0.05, width: Opus.NAVIGATION_WIDTH, height: Opus.NAVIGATION_HEIGHT*2)
    initialStaffWidth = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    initialImageViewFrame = CGRect(x: 0, y: frameYOffset, width: initialStaffWidth, height: Opus.NAVIGATION_HEIGHT * 2)
    squareViewFrame = CGRect(x: 0, y: 0, width: initialStaffWidth, height: Opus.NAVIGATION_HEIGHT)
    elongationConstant = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    contentInsetConstant = Opus.NAVIGATION_WIDTH/2 - initialStaffWidth/2

    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
    
    viewControllerFrame = CGRect(x: 0, y: Opus.SCREEN_HEIGHT * 0.05, width: Opus.NAVIGATION_WIDTH, height: Opus.NAVIGATION_HEIGHT)
    initialStaffWidth = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    initialImageViewFrame = CGRect(x: 0, y: frameYOffset, width: initialStaffWidth, height: Opus.NAVIGATION_HEIGHT * 2)
    squareViewFrame = CGRect(x: 0, y: 0, width: initialStaffWidth, height: Opus.NAVIGATION_HEIGHT)
    elongationConstant = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    contentInsetConstant = Opus.NAVIGATION_WIDTH/2 - initialStaffWidth/2
    
    super.init(coder: aDecoder)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    //setConstants()
    
    view.frame = viewControllerFrame
    
    setUpStaff()
    setUpSquare()
    /*
    for var i = 0; i < numberOfStartingMeasures; i++ {
      staffNavigationScrollView!.addSubview(imageViews[i])
    }
    */
    staffNavigationScrollView!.addSubview(imageViews[0])
    self.view.addSubview(staffNavigationScrollView!)
    self.view.addSubview(locationIndicatorSquare)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func setUpStaff(){
    /*
    / the size of the UIScrollView's frame is the same as the frame of its container, StaffNavigationViewController.view
    / the inital size of the UIScrollView's content size is the same as the size of the _staffImageView
    / contentSize.width gets updated as the staff gets longer, while contentSize.height stays constant
    */
    
    for var i = 0; i < numberOfStartingMeasures; i++ {
      var tempX = CGFloat(i) * initialStaffWidth
      var imageViewFrame = CGRect(x: tempX, y: frameYOffset, width: initialImageViewFrame.width, height: initialImageViewFrame.height)
      var staffImageView = UIImageView(frame: imageViewFrame)
      staffImageView.contentMode = UIViewContentMode.ScaleAspectFill
      imageViews.append(staffImageView)
      UpdateStaffNavigatorImage(index: i, invoker: container.staffEditor, target: self).run()
      currentIndex++
    }
    
    staffNavigationScrollView = StaffNavigationScrollView(size: viewControllerFrame.size, owner: self)
    staffNavigationScrollView!.userInteractionEnabled = true
    staffNavigationScrollView!.showsHorizontalScrollIndicator = false
    staffNavigationScrollView!.bounces = false
    staffNavigationScrollView!.contentSize = CGSize(width: initialImageViewFrame.width, height: initialImageViewFrame.height)
    staffNavigationScrollView!.contentInset = UIEdgeInsetsMake(0, contentInsetConstant, 0, contentInsetConstant)
    //the above line centers the nav-staff that is initialized. THIS LINE CENTERS PROPERLY IFF ONE STAFF'S WORTH OF LENGTH IS INSTANTIATED
    //this implementation makes the inital contentOffset == (-412, 0)
    
    //sets up the number of initialized "measures"
    staffNavigationScrollView!.contentSize.width *= CGFloat(self.numberOfStartingMeasures)
    
    
  }
  
  
  
  func setUpSquare(){
    // creates the central square
    
    locationIndicatorSquare.userInteractionEnabled = false
    locationIndicatorSquare.frame = CGRect(x: contentInsetConstant-2.5, y:-15, width: squareViewFrame.width+5, height: squareViewFrame.height+30)
    locationIndicatorSquare.backgroundColor = UIColor.cyanColor().colorWithAlphaComponent(0.1)
    locationIndicatorSquare.layer.borderWidth = 5
    locationIndicatorSquare.layer.cornerRadius = 5
    locationIndicatorSquare.layer.borderColor = UIColor.blueColor().colorWithAlphaComponent(0.7).CGColor

  }
  
  //MARK: - Gesture Event Callbacks
  
  //TODO: Fill in method stubs
  
  func oneFingerSingleTap(gestureRecognizer: UITapGestureRecognizer) {
    
  }
  
  func twoFingerDrag(gestureRecognizer: UIPanGestureRecognizer) {
    
  }
  
  //MARK: - Graphics Helper Functions
  
  func elongateStaff(){
    staffNavigationScrollView!.contentSize.width += elongationConstant
    currentIndex++
    var tempX = CGFloat(currentIndex) * initialImageViewFrame.width
    var imageViewFrame = CGRect(x: tempX, y: frameYOffset, width: initialImageViewFrame.width, height: initialImageViewFrame.height)
    var staffImageView = UIImageView(frame: initialImageViewFrame)
    staffImageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageViews.append(staffImageView)
    UpdateStaffNavigatorImage(index: currentIndex, invoker: container.staffEditor, target: self).run()
    staffNavigationScrollView!.addSubview(imageViews[currentIndex])
  }
  
  
  func staffInSquare() -> CGFloat {
    //staffNavigationScrollView!.dragging
    var currentPos = (staffNavigationScrollView!.contentOffset.x + contentInsetConstant)
    var positionRatio = currentPos/staffNavigationScrollView!.contentSize.width
    return positionRatio
  }
  
  
  func updatePosition(x_ratio: CGFloat){
    staffNavigationScrollView!.contentOffset = CGPointMake(x_ratio*staffNavigationScrollView!.contentSize.width - contentInsetConstant, 0)
  }

  
  func updateImageView(image: UIImage, index: Int){
    imageViews[index].image = image
    if index==0{
      imageViews[index].backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.5)
    }else{
      imageViews[index].backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
    }
  }

}
