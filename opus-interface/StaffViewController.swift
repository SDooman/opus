//
//  StaffViewController.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/16/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class StaffViewController: ViewController {
    

    var pageController: DMDynamicViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController1 = MeasureViewController()
        let viewController2 = MeasureViewController()
        
        let viewControllers = [viewController1, viewController2]
        
        pageController = DMDynamicViewController(viewControllers: viewControllers)
        self.view.addSubview(pageController!.view)
      
        // Legacy code, might need later - taken out now with no apparent problems,
        // but wanted to keep in case of unexpected bugs.
        //self.view.window?.rootViewController = pageController
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ignore this for now.
    func updateDescription() -> String {
        return "Nothing set"
    }

}
