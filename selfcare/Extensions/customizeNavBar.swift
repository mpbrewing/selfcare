//
//  customizeNavBar.swift
//  selfcare
//
//  Created by Michael Brewington on 12/5/20.
//

import Foundation
import UIKit

extension UIViewController {
    func modifyAddNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.gray, .font: UIFont(name: "Nexa-Bold", size: 22)!]
    }
}
