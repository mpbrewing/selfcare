//
//  OnADateCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/26/21.
//

import Foundation
import UIKit

class OnADateCell: UIView{
    
    @IBOutlet var viewHandle: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        viewHandle = loadViewFromNib(name: "OnADateView")
        // use bounds not frame or it'll be offset
        viewHandle!.frame = bounds
        // Make the view stretch with containing view
        viewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(viewHandle!)
        handleInit()
    }
    
    func handleInit(){
        
    }
    
}
