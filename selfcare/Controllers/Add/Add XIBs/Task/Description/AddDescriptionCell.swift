//
//  AddDescriptionCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    //Change to TextView when you descide to make expandable
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Update NIB on init
        setupXIB()
    }
    
    func setupXIB() {
        //Change Cell Icon Tint Color to Gainsboro
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        //Update Placeholder Text and Color
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Enter description",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func passDescriptionText()
    {
        //Pass Index and Description Text
        let notif = ["index":0,"description":descriptionTextField.text!] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
    
    @IBAction func EditingDidEnd(_ sender: Any) {
        //passDescriptionText()
    }
    
    
    
}
