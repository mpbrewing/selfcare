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
