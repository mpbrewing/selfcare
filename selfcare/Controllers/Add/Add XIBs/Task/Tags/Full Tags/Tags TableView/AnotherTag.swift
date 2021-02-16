//
//  AnotherTag.swift
//  selfcare
//
//  Created by Michael Brewington on 2/15/21.
//

import Foundation
import UIKit

class AnotherTag: UITableViewCell {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        label.text = "+"
        label.textColor = UIColor.gainsboro
        bg.layer.cornerRadius = 10
        bg.layer.borderColor = UIColor.gainsboro.cgColor
        bg.layer.borderWidth = 3
    }
    
}
