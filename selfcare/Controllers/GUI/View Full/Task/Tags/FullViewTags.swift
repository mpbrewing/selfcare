//
//  FullViewTags.swift
//  selfcare
//
//  Created by Michael Brewington on 3/18/21.
//

import Foundation
import UIKit

class FullViewTags: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    var tags: [Tag] = [Tag]() {
       didSet {
            setupXIB()
       }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.white
        if tags.count > 0 {
            tagsLabel.textColor = UIColor.white
        } else {
            tagsLabel.textColor = UIColor.gainsboro
        }
        emoji.text = "🏷"
        icon.isHidden = true
    }
    
}
