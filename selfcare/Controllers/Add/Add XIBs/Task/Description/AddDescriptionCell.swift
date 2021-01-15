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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
        
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Enter description",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    
}
