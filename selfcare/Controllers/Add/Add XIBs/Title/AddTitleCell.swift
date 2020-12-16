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
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func returnText() -> [String:Any]{
        let holdTextInput: [String:Any] = ["segueID":0,"emoji":EmojiTextField.text ?? "","title":TitleTextField.text ?? ""]
        return holdTextInput
    }
    
     func passSegue()
     {
         NotificationCenter.default.post(name: .addFolderDetails, object: nil,userInfo: returnText())
     }
    
    
}
