//
//  hideKeyboardWhenTappedAround.swift
//  selfcare
//
//  Created by Michael Brewington on 11/16/20.
//

import UIKit

extension UIViewController {
    public func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
