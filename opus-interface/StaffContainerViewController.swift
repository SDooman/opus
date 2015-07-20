//
//  StaffViewController.swift
//  opus-interface
//
//  Created by Samuel Dooman on 6/29/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

//https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIViewController_Class/

class StaffContainerViewController: UIViewController {
  
  /*
  //MARK: - Properties
  //MARK: FIRST WAY OF HANDLING INSTANCES
  // ===================================================


  private var navigatorIndex = 0
  private var editorIndex = 1
  private var playbackMenuIndex = 2
  
  //TODO: Refactor so that Staff View Controllers
  //      are constructed with a ViewModel passed in
  //      useful for making custom staffs (key sig, time sig)

  var staffEditor : StaffEditorViewController {
    return childViewControllers[editorIndex]
      as! StaffEditorViewController
  }
  
  var staffNavigator : StaffNavigationViewController {
    return childViewControllers[navigatorIndex]
      as! StaffNavigationViewController
  }
  
  var playbackMenu : PlaybackMenuViewController {
    return childViewControllers[playbackMenuIndex]
      as! PlaybackMenuViewController
  }
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    // Programmatically draw child view controllers' views
    
    setUpChildViewControllers()
  }
  
  func setUpChildViewControllers() {
    
    //TODO: [SD] Should logic of addingChildViewController
    //      Live in the constructor of the child view controllers?
    
    self.addChildViewController(StaffNavigationViewController())
    self.view.addSubview(staffNavigator.view)
    
    self.addChildViewController(StaffEditorViewController())
    self.view.addSubview(staffEditor.view)
    
    self.addChildViewController(PlaybackMenuViewController())
    self.view.addSubview(playbackMenu.view)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  */
  // ===================================================

  
  //MARK: SECOND WAY OF HANDLING CHILDREN
  
  let staffNavigator : StaffNavigationViewController
  let staffEditor : StaffEditorViewController
  let staffViewModel : StaffViewModel
  let playBackMenu : PlaybackMenuViewController

  init() {
    staffViewModel = StaffViewModel()
    
    staffEditor = StaffEditorViewController()
    playBackMenu = PlaybackMenuViewController()
    staffNavigator = StaffNavigationViewController()
    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
    staffViewModel = StaffViewModel()
    
    staffEditor = StaffEditorViewController()
    playBackMenu = PlaybackMenuViewController()
    staffNavigator = StaffNavigationViewController()
    //println("called coder in containerVC")
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.addChildViewController(staffEditor)
    self.addChildViewController(playBackMenu)
    self.addChildViewController(staffNavigator)
    
    
    self.view.addSubview(staffEditor.view)
    self.view.addSubview(playBackMenu.view)
    self.view.addSubview(staffNavigator.view)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
