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
  
  //MARK: - Properties
  
  private var navigatorIndex = 0
  private var editorIndex = 1
  private var playbackMenuIndex = 2
  
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
    
    addChildViewController(StaffNavigationViewController())
    self.view.addSubview(staffNavigator.view)
    
    addChildViewController(StaffEditorViewController())
    self.view.addSubview(staffEditor.view)
    
    addChildViewController(PlaybackMenuViewController())
    self.view.addSubview(playbackMenu.view)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
