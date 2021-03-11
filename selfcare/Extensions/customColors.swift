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
    
    class var lightGains: UIColor {
        return UIColor.init(red: 240, green: 240, blue: 240)
    }
    
    class var appleBlue: UIColor {
        return UIColor.init(red: 0, green: 159, blue: 235)
    }
    
    class var applePurple: UIColor {
        return UIColor.init(red: 151, green: 68, blue: 151)
    }
    
    class var appleRed: UIColor {
        return UIColor.init(red: 229, green: 68, blue: 58)
    }
    
    class var appleOrange: UIColor {
        return UIColor.init(red: 250, green: 134, blue: 0)
    }
    
    class var appleYellow: UIColor {
        return UIColor.init(red: 254, green: 183, blue: 5)
    }
    
    class var appleGreen: UIColor {
        return UIColor.init(red: 95, green: 182, blue: 65)
    }
    
    class var hippiePink: UIColor {
        return UIColor.init(red: 178, green: 76, blue: 90)
    }
    
    class var madang: UIColor {
        return UIColor.init(red: 191, green: 244, blue: 169)
    }
    
    class var conifer: UIColor {
        return UIColor.init(red: 192, green: 237, blue: 84)
    }
    
    class var yourPink: UIColor {
        return UIColor.init(red: 250, green: 190, blue: 190)
    }
    
    class var pGreen1: UIColor {
        return UIColor.init(red: 182, green: 226, blue: 149)
    }
    
    class var pGreen2: UIColor {
        return UIColor.init(red: 134, green: 223, blue: 119)
    }
    
    class var pGreen3: UIColor {
        return UIColor.init(red: 93, green: 206, blue: 89)
    }
    
    class var silver: UIColor {
        return UIColor.init(red: 190, green: 190, blue: 190)
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
    
    //https://stackoverflow.com/questions/35073272/button-text-uicolor-from-hex-swift
    //https://stackoverflow.com/questions/41843262/convert-hex-color-as-string-to-uint
    convenience init(rgb: UInt) {
           self.init(rgb: rgb, alpha: 1.0)
       }

       convenience init(rgb: UInt, alpha: CGFloat) {
           self.init(
               red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgb & 0x0000FF) / 255.0,
               alpha: CGFloat(alpha)
           )
       }
    
    /*
    var color = details["color"] as? String ?? "#ff0000"
    color.removeFirst()
    let string = "0x\(color)"
    print(string)
    let hexValue = UInt(String(string.suffix(6)), radix: 16) ?? 0
    let holdColor = UIColor.init(rgb: hexValue)
    */

    
}

extension UINavigationController {
   public override var preferredStatusBarStyle: UIStatusBarStyle {
    //print("\(viewControllers.last?.isMember(of: FullGUI.self) ?? false)")
    if viewControllers.last?.isMember(of: FullGUI.self) == true {
        return .lightContent
    } else {
        return .darkContent
    }
        //return .darkContent
        //return viewControllers[0].preferredStatusBarStyle
   }
}
