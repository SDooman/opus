//
//  UpdateStaffNavigatorImage.swift
//  opus-interface
//
//  Created by Peter Bowden on 7/16/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import UIKit

class UpdateStaffNavigatorImage: Command {
  
  let invoker: StaffEditorViewController
  let target: StaffNavigationViewController
  
  init(invoker: StaffEditorViewController,
    target: StaffNavigationViewController) {
      self.invoker = invoker
      self.target = target
      
  }
  func run() {
    target.updateImageView(invoker.staffSnapshot())
  }
}
