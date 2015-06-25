//
//  FloatingMenuPopViewController.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/22/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class FloatingMenuPopViewController: UIViewController {
    
    var myMeasureViewController: MeasureViewController?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, measureView: MeasureViewController) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        myMeasureViewController = measureView
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
