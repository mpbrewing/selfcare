//
//  FullViewPriority.swift
//  selfcare
//
//  Created by Michael Brewington on 3/18/21.
//

import Foundation
import UIKit

class FullViewPriority: UITableViewCell{
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    var priority = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.white
        if priority > 0 {
            priorityLabel.textColor = UIColor.white
        } else {
            priorityLabel.textColor = UIColor.gainsboro
        }
        emoji.text = "❗️"
        icon.isHidden = true
    }
    
}
