//
//  UINote
//
//
//  Created by Nick DeMarco on 6/16/15.
//  Copyright (c) 2015 Nick DeMarco. All rights reserved.
//

import Foundation
import UIKit

//let spaces = [85.0, 101.0, 116.0, 133.0, 148.5, 165.0, 180.0, 196.5, 211.5, 228.5]
let spaces:[Double] = [78.0, 91.0, 103.0, 115.0, 127.0, 139.0, 151.0, 163.0, 175.0]
let verticalNoteCushion:Double = 7

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
            noteAdjust = CGPoint(x: 0, y: 35.0)
        case .Eighth:
            imageName = "eighth_note"
            noteAdjust = CGPoint(x: -15.0, y: 35.0)
        case .Sixteenth:
            imageName = "sixteenth_note"
            noteAdjust = CGPoint(x: -15, y: 35.0)
        }
        
        image = UIImage(named: imageName!)
        imageView = UIImageView(image: image!)
        
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
        
        let setTo:CGPoint = CGPoint(x: locX - adjX, y: locY)
        imageView!.center = setTo
    }
    
    func getVerticalPosition(clickLocation: CGPoint) -> CGPoint {
        let clickY:Double = Double(clickLocation.y)
        let adjY:Double = Double(noteAdjust!.y)
        var newY: CGFloat?
        
        for index in 0...spaces.count - 1 {
            if (clickY - adjY) < (spaces[index] + verticalNoteCushion) {
                self.vertIndex = index // temporary fix, not extensible to key signature situations.
                return CGPoint(x: clickLocation.x, y: CGFloat(spaces[index]))
            }
        }
        return CGPoint(x: clickLocation.x, y: CGFloat(spaces[spaces.count-1]))
    }
    
}



