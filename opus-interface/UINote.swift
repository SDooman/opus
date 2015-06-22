//
//  UINote
//
//
//  Created by Nick DeMarco on 6/16/15.
//  Copyright (c) 2015 Nick DeMarco. All rights reserved.
//

import Foundation
import UIKit

let Constants: GraphicConstants = GraphicConstants()
let vertSpaces: [Float] = Constants.myVertLineSpaceArray!
let horizontalSpaces: [Float] = Constants.myHorizontalGridArray!

// Saving the following as the original non-programmatic calculation of the space array (I just found them manually, some are off slightly, but work fine.)
//let spaces: [Double] = [207.0, 230.0, 253.0, 276.0, 298.0, 321.0, 344.0, 367.0, 390.0, 413.0, 437.0]

let verticalNoteCushion:Double = 7
let horizontalNoteCushion:Double = 12
let screenSizeWidth = UIScreen.mainScreen().bounds.width
let screenSizeHeight = UIScreen.mainScreen().bounds.height

enum NoteValue : Printable {
    case Whole, Half, Quarter, Eighth, Sixteenth
    var description : String {
        switch self {
        case .Whole: return "Whole Note"
        case .Half: return "Half Note"
        case .Quarter: return "Quarter Note"
        case .Eighth: return "Eighth Note"
        case .Sixteenth: return "Sixteenth Note"
        }
    }
}

class UINote {
    
    let value: NoteValue?
    let imageName: String?
    let image: UIImage?
    let imageView: UIImageView?
    let noteAdjust: CGPoint?
    var vertIndex: Int? = nil
    var mySize: CGSize? = nil

    init(value: NoteValue){
        self.value = value
        
        switch value {
        case .Whole:
            imageName = "whole_note"
            noteAdjust = CGPoint(x: 0, y: 0.0)
        case .Half:
            imageName = "half_note"
            noteAdjust = CGPoint(x: 0, y: 35.0)
        case .Quarter:
            imageName = "quarter_note"
            noteAdjust = CGPoint(x: 0, y: 70.0)
        case .Eighth:
            imageName = "eighth_note"
            noteAdjust = CGPoint(x: -15.0, y: 35.0)
        case .Sixteenth:
            imageName = "sixteenth_note"
            noteAdjust = CGPoint(x: -15, y: 35.0)
        }
        
        image = UIImage(named: imageName!)
        imageView = UIImageView(image: image!)
        
        let myHeight = screenSizeHeight / 4.5
        let myWidth = screenSizeWidth / 17
        mySize = CGSizeMake(myWidth, myHeight)
        
        /*
        println("------BEGIN------")
        println()
        
        println("My height: \(myHeight)")
        println("My width: \(myWidth)")
        println("My height / screen height \(myHeight / screenSizeHeight)")
        println("My width / screen width \(myWidth / screenSizeWidth)")
        println("Middle line: 321")
        println("Spaces \(spaces)")
        println("Screen Height: \(screenSizeHeight)")
        println("Screen Width: \(screenSizeWidth)")
        println(Constants.myVerticalLineSpacing!)
        println()
        println("------END------")
        */
    }
    
    func getNoteCenter() -> CGPoint {
        let x = noteAdjust!.x + imageView!.center.x
        let y = noteAdjust!.y + imageView!.center.y
        return CGPoint(x: x, y: y)
    }
    
    func setLocation(clickAt: CGPoint) {
        let locX = getVerticalPosition(clickAt).x
        let locY = getVerticalPosition(clickAt).y
        let adjX = noteAdjust!.x
        let adjY = noteAdjust!.y
        
        let setTo:CGPoint = CGPoint(x: locX - adjX , y: locY)
        imageView!.center = setTo
    }
    
    func getVerticalPosition(clickLocation: CGPoint) -> CGPoint {
        let clickX: Float = Float(clickLocation.x)
        let adjX: Float = Float(noteAdjust!.x)
        let clickY:Float = Float(clickLocation.y)
        let adjY:Float = Float(noteAdjust!.y)
        var newY: CGFloat?
        
        var returnX: CGFloat? = nil
        var returnY: CGFloat? = nil
        
        for index in 0...vertSpaces.count - 1 {
            if (clickY - adjY) < (vertSpaces[index] + Float(verticalNoteCushion)) {
                //self.vertIndex = index // temporary fix, not extensible to key signature situations.
                //return CGPoint(x: clickLocation.x, y: CGFloat(vertSpaces[index]))
                returnY = CGFloat(vertSpaces[index])
                break
            }
        }
    
        for index in 0...horizontalSpaces.count - 1{
            if (clickX - adjX) < (horizontalSpaces[index] + Float(horizontalNoteCushion)) {
                returnX = CGFloat(horizontalSpaces[index])
                break
            }
        }
        
        println(returnX)
        println(returnY)
        
        
        if returnY == nil{
            returnY = CGFloat(vertSpaces[vertSpaces.count-1])
            println("max y")
        }
        if returnX == nil{
            returnX = CGFloat(horizontalSpaces[horizontalSpaces.count - 1])
            println("max X")
        }
        
        return CGPoint(x: returnX!, y: returnY!)
    }
    
}



