//
//  SelectionRowCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/23/21.
//

import Foundation
import UIKit

class SelectionRowCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bg: UIView!
    
    var iconArray = [UIImage]()
    var labelArray = [String]()
    var excludedCount = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelArray = ["Does not end","Ends on a date","After number of occurrences","\(updateExcludedString()) excluded dates"]
        iconArray = [#imageLiteral(resourceName: "infinity"),#imageLiteral(resourceName: "onADate"),#imageLiteral(resourceName: "NumberOfOccurences"),#imageLiteral(resourceName: "excluded")]
    }
    
    func updateExcludedString() -> String {
        if excludedCount > 0 {
            return "\(excludedCount)"
        } else {
            return "No"
        }
    }
    
    func updateLabel(index: Int, selected: Bool){
        label.text = labelArray[index]
        icon.image = iconArray[index]
        updateColor(selected: selected)
        updateExcluded(index: index, selected: selected)
    }
    
    func updateColor(selected: Bool){
        if selected == true {
            label.textColor = UIColor.appleRed
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = UIColor.appleRed
        } else {
            label.textColor = UIColor.gainsboro
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = UIColor.gainsboro
        }
    }
    
    func updateExcluded(index: Int,selected: Bool){
        if index == 3 {
            bg.layer.cornerRadius = 10
            bg.layer.borderWidth = 3
            if selected == true {
                bg.layer.borderColor = UIColor.appleRed.cgColor
            } else {
                bg.layer.borderColor = UIColor.gainsboro.cgColor
            }
        }
    }
    
}
