//
//  UpdateStaffNavigatorPosition.swift
//  opus-interface
//
//  Created by Peter Bowden on 7/20/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import UIKit

class UpdateStaffNavigatorPosition: Command {
  
  let x_ratio: CGFloat
  let target: StaffNavigationViewController
  
  init(x_ratio: CGFloat,
    target: StaffNavigationViewController) {
      self.x_ratio = x_ratio
      self.target = target
  }
  
  func run() {
    target.updatePosition(x_ratio)
  }
}
