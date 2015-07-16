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
  let locationIndicatorSquare = UIView()
  let staffImageView: UIImageView
  let viewControllerFrame: CGRect
  var notes: Set<UINote> = []
  
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
    viewControllerFrame = CGRect(x: 0, y: Opus.SCREEN_HEIGHT * 0.05, width: Opus.NAVIGATION_WIDTH, height: Opus.NAVIGATION_HEIGHT)
    initialStaffWidth = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    initialImageViewFrame = CGRect(x: 0, y: 0, width: initialStaffWidth, height: Opus.NAVIGATION_HEIGHT)
    elongationConstant = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    contentInsetConstant = Opus.NAVIGATION_WIDTH/2 - initialStaffWidth/2
    
    let staffImage = UIImage(named: "staff_vector")
    staffImageView = UIImageView(image: staffImage)
    staffImageView.frame = initialImageViewFrame

    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
    viewControllerFrame = CGRect(x: 0, y: Opus.SCREEN_HEIGHT * 0.05, width: Opus.NAVIGATION_WIDTH, height: Opus.NAVIGATION_HEIGHT)
    initialStaffWidth = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    initialImageViewFrame = CGRect(x: 0, y: 0, width: initialStaffWidth, height: Opus.NAVIGATION_HEIGHT)
    elongationConstant = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    contentInsetConstant = Opus.NAVIGATION_WIDTH/2 - initialStaffWidth/2
    
    let staffImage = UIImage(named: "staff_vector")
    staffImageView = UIImageView(image: staffImage)
    staffImageView.frame = initialImageViewFrame
    
    super.init(coder: aDecoder)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    //setConstants()
    
    view.frame = viewControllerFrame
    
    setUpStaff()
    setUpSquare()
    
    staffNavigationScrollView!.addSubview(staffImageView)
    self.view.addSubview(staffNavigationScrollView!)
    self.view.addSubview(locationIndicatorSquare)
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
  func setConstants(){
    viewControllerFrame = CGRect(x: 0, y: Opus.SCREEN_HEIGHT * 0.05, width: Opus.NAVIGATION_WIDTH, height: Opus.NAVIGATION_HEIGHT)
    initialStaffWidth = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    imageViewFrame = CGRect(x: 0, y: 0, width: initialStaffWidth!, height: Opus.NAVIGATION_HEIGHT)
    elongationConstant = Opus.NAVIGATION_HEIGHT * CGFloat(Opus.STAFF_IMAGE_WIDTH_HEIGHT_RATIO)
    view.frame = viewControllerFrame!
    contentInsetConstant = Opus.NAVIGATION_WIDTH/2 - initialStaffWidth!/2
  }*/
  
  func setUpStaff(){
    /*
    / the size of the UIScrollView's frame is the same as the frame of its container, StaffNavigationViewController.view
    / the inital size of the UIScrollView's content size is the same as the size of the _staffImageView
    / contentSize.width gets updated as the staff gets longer, while contentSize.height stays constant
    */
    staffNavigationScrollView = StaffNavigationScrollView(size: viewControllerFrame.size, owner: self)
    staffNavigationScrollView!.userInteractionEnabled = true
    staffNavigationScrollView!.showsHorizontalScrollIndicator = false
    staffNavigationScrollView!.bounces = false
    staffNavigationScrollView!.contentSize = CGSize(width: staffImageView.frame.size.width, height: staffImageView.frame.size.height)
    staffNavigationScrollView!.contentInset = UIEdgeInsetsMake(0, contentInsetConstant, 0, contentInsetConstant)
    //the above line centers the nav-staff that is initialized. THIS LINE CENTERS PROPERLY IFF ONE STAFF'S WORTH OF LENGTH IS INSTANTIATED
    //this implementation makes the inital contentOffset == (-412, 0)
    
    //sets up the number of initialized "measures"
    staffNavigationScrollView!.contentSize.width *= CGFloat(self.numberOfStartingMeasures)
    staffImageView.frame.size.width *= CGFloat(self.numberOfStartingMeasures)
    
  }
  
  
  
  func setUpSquare(){
    // creates the central square
    
    locationIndicatorSquare.userInteractionEnabled = false
    locationIndicatorSquare.frame = CGRect(x: contentInsetConstant-2.5, y:-15, width: initialImageViewFrame.width+5, height: initialImageViewFrame.height+30)
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
    staffImageView.frame.size.width += elongationConstant
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

  func insertNote(note: UINote){
  }
  
  func makeNote(location: CGPoint){
    let image = UIImage(named: "quarter_note")
    let imageView = UIImageView(image: image)
    imageView.frame = CGRect(x: location.x, y: location.y, width: Opus.NAVNOTE_WIDTH, height: Opus.NAVNOTE_HEIGHT)
    staffNavigationScrollView!.addSubview(imageView)
  }

}
