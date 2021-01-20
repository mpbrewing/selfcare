//
//  rotateExtension.swift
//  selfcare
//
//  Created by Michael Brewington on 1/20/21.
//

import Foundation
import UIKit

extension UIView {
/*
    /**
     Rotate a view by specified degrees

     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }*/
    
    func getDegrees(point: CGPoint, origin: CGPoint) -> CGFloat {
        let deltaX = point.x - origin.x
        let deltaY = point.y - origin.y
        let radians = atan2(deltaY, deltaX)
        let degrees = radians * (180.0 / CGFloat.pi)
        guard degrees < 0 else {
            return degrees
        }
        return degrees + 360.0
    }
    
    func getClockDegrees(point: CGPoint, origin: CGPoint) -> CGFloat {
        var angle = getDegrees(point: point, origin: origin)
        angle = angle + 90.0
        if angle > 360{
            angle = angle - 360
        }
        return angle
    }
    
    func distanceToPoint(point: CGPoint,origin: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - origin.x), 2) + pow((point.y - origin.y), 2))
    }
    
    func insideTheCircle(distance: CGFloat,radius:CGFloat) -> Bool {
        if distance <= radius {
            return true
        } else {
            return false
        }
    }
    

}

