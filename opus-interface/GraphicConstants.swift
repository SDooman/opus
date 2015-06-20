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
    let myLineSpaceArray: [Float]?
    private var myTempLineSpaceArray: [Float]?
    
    
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
        
        myTempLineSpaceArray = [Float]()

        for i in -5...5 {
            var toAdd = Float(i) * myVerticalLineSpacing! + myMidline!
            myTempLineSpaceArray?.append(toAdd)
        }
        myLineSpaceArray = myTempLineSpaceArray
    }
}