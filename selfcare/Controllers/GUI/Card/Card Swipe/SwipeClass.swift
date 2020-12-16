//
//  SwipeClass.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit

class SwipeClass: UIView {
    
    @IBOutlet var ViewHandle: UIView!
    
    @IBOutlet weak var Card12: CardClass!
    @IBOutlet weak var Card13: CardClass!
    @IBOutlet weak var signal: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        ViewHandle = loadViewFromNib(name: "SwipeView")
        // use bounds not frame or it'll be offset
        ViewHandle!.frame = bounds
        // Make the view stretch with containing view
        ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(ViewHandle!)
        handleInit()
    }
     
    func handleInit() {
        for card in [Card12,Card13] {
            card?.layer.cornerRadius = 20
        }
        signal.layer.cornerRadius = 4
    }
 
    
}

//-332, 0, 332, 638
//10,0, 332, 638
//352, 0, 166, 319
//528, 0, 332,638

//y: 680
//y: -660
