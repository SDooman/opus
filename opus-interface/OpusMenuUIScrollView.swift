//
//  OpusMenuUIScrollView.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/23/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import UIKit

class OpusMenuUIScrollView: UIScrollView {
    
    private let _headerBar: UIView = UIView()

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        _headerBar.frame.size = CGSize(width: screenSize.width, height: screenSize.height/10.0)
        _headerBar.backgroundColor = UIColor(red: 127.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let location = CGPointMake(0, contentOffset.y)
        let size = _headerBar.frame.size
        _headerBar.frame = CGRect(origin: location, size: size)
        self.superview!.superview!.addSubview(_headerBar) // staff, right?
        
        self.setupMenu()
        
    }
    
    func setupMenu() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        var button: UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRect(x: 0, y: 0, width: screenSize.width/10, height: screenSize.height/15)
        button.backgroundColor = UIColor.blackColor()
        button.setTitle("Do Thing", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        _headerBar.addSubview(button)
        /*
        var constY = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: _headerBar, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        _headerBar.addConstraint(constY)
        
        var constX = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: _headerBar, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        _headerBar.addConstraint(constX)
        */
        
    }

}
