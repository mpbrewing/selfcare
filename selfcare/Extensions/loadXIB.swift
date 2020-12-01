//
//  loadXIB.swift
//  selfcare
//
//  Created by Michael Brewington on 11/19/20.
//

import Foundation
import UIKit

extension UIViewController {

    public func loadXIB(name: String) {
        Bundle.main.loadNibNamed(name, owner: self, options: nil)
    }

}

extension UIView {
    
   public func loadViewFromNib(name: String) -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}

