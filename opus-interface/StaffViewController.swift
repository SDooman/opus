//
//  StaffViewController.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/16/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class StaffViewController: ViewController, Printable {
    
    //override var description: String {get {return updateDescription()}}
    //var currentButton: UIButton? = nil
    var pageController: DMDynamicViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController1 = MeasureViewController()
        let viewController2 = MeasureViewController()
        
        let viewControllers = [viewController1, viewController2]
        
        pageController = DMDynamicViewController(viewControllers: viewControllers)
        self.view.addSubview(pageController!.view)
        self.view.window?.rootViewController = pageController
        
        //currentButton = createNewMeasureButton(viewController2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ignore this for now.
    func updateDescription() -> String {
        return "Nothing set"
    }
    /*
    func createNewMeasureButton(viewController: UIViewController) -> UIButton {
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("New Page", forState: UIControlState.Normal)
        button.addTarget(self, action: "newMeasureButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.center = CGPointMake(100, 50)
        viewController.view.addSubview(button)
        return button
    }
    */
    /*
    func newMeasureButtonAction(sender: UIButton!){
        let newViewController = MeasureViewController()
        newViewController.view.backgroundColor = UIColor.whiteColor()
        
        currentButton?.removeFromSuperview()
        
        let button: UIButton = createNewMeasureButton(newViewController)
        newViewController.view.addSubview(button)
        currentButton = button
        
        //button.center = CGPointMake(newViewController.view.frame.size.width  / 2,
        //newViewController.view.frame.size.height / 2)
        button.center = CGPointMake(100, 50)
        
        pageController?.insertPage(newViewController, atIndex: pageController!.count())
    }
    */

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
