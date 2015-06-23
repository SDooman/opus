//
//  GraphicConstants.swift
//  opus-interface
//
//  Created by Nick DeMarco on 6/19/15.
//  Copyright (c) 2015 Sam Dooman. All rights reserved.
//

import Foundation
import UIKit

struct GraphicConstants {
    let screenWidth: Float?
    let screenHeight: Float?
    let widthHeightRatio: Float?
    let myScreenRatio: Float?
    let myScreenHeightMultiplier: Float?
    let myVerticalLineSpacing: Float?
    let myMidline: Float?
    let myNoteHeight: Float?
    let myNoteWidth: Float?
    let myVertLineSpaceArray: [Float]?
    private var myTempVertLineSpaceArray: [Float]?
    
    let numberOfHorizontalBuckets:Int?
    let myLeftWallCushion: Float?
    let myHorizontalGridArray: [Float]?
    private var myTempHorizontalGridArray:[Float]?
    
    
    
    init() {
        screenWidth = Float(UIScreen.mainScreen().bounds.width)
        screenHeight = Float(UIScreen.mainScreen().bounds.height)
        widthHeightRatio = 1 + (1/3)
        myScreenRatio = Float((screenWidth!/screenHeight!))
        myScreenHeightMultiplier = myScreenRatio! / widthHeightRatio!
        myVerticalLineSpacing = 0.02994792 * screenHeight! * myScreenHeightMultiplier!
        myMidline = (0.41796875) * screenHeight! * myScreenHeightMultiplier!
        myNoteHeight = (1 / 4.5) * screenHeight! * myScreenHeightMultiplier!
        myNoteWidth = (1 / 17) * screenWidth!
        
        numberOfHorizontalBuckets = 16
        myLeftWallCushion = 40.0
        
        
        myTempVertLineSpaceArray = [Float]()

        for i in -5...5 {
            var toAdd = Float(i) * myVerticalLineSpacing! + myMidline!
            myTempVertLineSpaceArray?.append(toAdd)
        }
        myVertLineSpaceArray = myTempVertLineSpaceArray
        
        let bucketSize: Float = (screenWidth! - myLeftWallCushion!) / Float(numberOfHorizontalBuckets!)
        myTempHorizontalGridArray = [Float]()
        myTempHorizontalGridArray?.append(myLeftWallCushion!)
        
        for i in 0...(numberOfHorizontalBuckets! - 1) {
            let toAdd = (Float(i) * bucketSize) + myLeftWallCushion!
            myTempHorizontalGridArray?.append(toAdd)
        }
        
        myHorizontalGridArray = myTempHorizontalGridArray
        println(myTempHorizontalGridArray)
        
    }
}