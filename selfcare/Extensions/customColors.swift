//
//  customColors.swift
//  selfcare
//
//  Created by Michael Brewington on 11/19/20.
//

import Foundation
import UIKit

extension UIColor {
    
    // #202124 - Black Russian (Approx.) - RGB: 32, 33, 36
    class var blackRussian: UIColor {
        return UIColor.init(red: 32, green: 33, blue: 36)
    }
    class var gainsboro: UIColor {
        return UIColor.init(red: 220, green: 220, blue: 220)
    }
    
    
    
    // https://stackoverflow.com/questions/49150872/how-to-convert-rgb-values-to-hex-string-ios-swift
    convenience init(red: Int, green: Int, blue: Int) {
          assert(red >= 0 && red <= 255, "Invalid red component")
          assert(green >= 0 && green <= 255, "Invalid green component")
          assert(blue >= 0 && blue <= 255, "Invalid blue component")

          self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
      }
    
        func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0

            getRed(&r, green: &g, blue: &b, alpha: &a)

            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

            return NSString(format:"#%06x", rgb) as String
        }

    
}

extension UINavigationController {
   public override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers[0].preferredStatusBarStyle
   }
}
