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
    
    // https://stackoverflow.com/questions/33942483/swift-extension-example
    class func rgb(fromHex: Int) -> UIColor {

        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
    convenience init(red: Int, green: Int, blue: Int) {
          assert(red >= 0 && red <= 255, "Invalid red component")
          assert(green >= 0 && green <= 255, "Invalid green component")
          assert(blue >= 0 && blue <= 255, "Invalid blue component")

          self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
      }
    
}

extension UINavigationController {
   public override var preferredStatusBarStyle: UIStatusBarStyle {
    return topViewController?.preferredStatusBarStyle ?? .default
   }
}
