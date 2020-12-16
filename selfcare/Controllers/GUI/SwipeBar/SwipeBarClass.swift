//
//  SwipeBarClass.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit

class SwipeBarClass: UIView {
    
    @IBOutlet var ViewHandle: UIView!
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         xibSetup()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         xibSetup()
     }
     
     func xibSetup() {
         ViewHandle = loadViewFromNib(name: "SwipeBarView")
         // use bounds not frame or it'll be offset
         ViewHandle!.frame = bounds
         // Make the view stretch with containing view
         ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
         // Adding custom subview on top of our view (over any custom drawing > see note below)
         addSubview(ViewHandle!)
         handleInit()
     }
      
     func handleInit() {
        ViewHandle.layer.cornerRadius = 20
     }
  
    
}
