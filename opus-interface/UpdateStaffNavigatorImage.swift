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
  
  let index: Int
  let invoker: StaffEditorViewController
  let target: StaffNavigationViewController
  
  init(index: Int, invoker: StaffEditorViewController,
    target: StaffNavigationViewController) {
      self.index = index
      self.invoker = invoker
      self.target = target
      
  }
  func run() {
    target.updateImageView(invoker.staffSnapshot(index), index: index)
  }
}
