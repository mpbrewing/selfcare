//
//  AddTitleCell.swift
//  selfcare
//
//  Created by Michael Brewington on 12/8/20.
//

import Foundation
import UIKit

class AddTitleCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var EmojiView: UIView!
    @IBOutlet weak var EmojiTextField: UITextField!
    
    var state = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
        passSegue()
    }
    
    func setupXIB() {
        EmojiView.layer.cornerRadius = 8
        TitleTextField.attributedPlaceholder = NSAttributedString(string: "Enter title",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        EmojiTextField.delegate = self
        TitleTextField.delegate = self
    }
    
    @IBAction func EmojiEditingChanged(_ sender: Any) {
        EmojiTextField.text = ""
    }
    @IBAction func EmojiEditingDidEnd(_ sender: Any) {
        passSegue()
    }
    
    @IBAction func titleEditingDidEnd(_ sender: Any) {
        passSegue()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == EmojiTextField {
            //print(string)
            let maxLength = 0
            //let currentString: NSString = textField.text! as NSString
            //let newString: NSString =
                   // currentString.replacingCharacters(in: range, with: string) as NSString
            if EmojiTextField.text!.count > 0 {
                EmojiTextField.text = string
            }
            return EmojiTextField.text!.count <= maxLength
        } else if textField == TitleTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                   currentString.replacingCharacters(in: range, with: string) as NSString
            if string == "\n" {
                TitleTextField.resignFirstResponder()
            }
            return newString.length <= maxLength
        } else {
            return true
        }
    }
    
    
    
    func returnDetails() -> [String:Any]{
        let holdTextInput: [String:Any] = ["index":0,"emoji":EmojiTextField.text ?? "","title":TitleTextField.text ?? ""]
        return holdTextInput
    }
    
     func passSegue()
     {
        if state == 0 {
            NotificationCenter.default.post(name: .addFolderDetails, object: nil,userInfo: returnDetails())
        } else {
            NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: returnDetails())
        }
     }
    
    
}
