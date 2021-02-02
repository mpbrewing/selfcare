//
//  WeekClass.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class WeekClass: UICollectionViewCell{
    
    @IBOutlet weak var label: UILabel!
    
    var weekArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weekArray = ["S","M","T","W","T","F","S"]
    }
    
    func updateLabel(index: Int,selected: Bool){
        label.text = weekArray[index]
        updateColor(selected: selected)
    }
    
    func updateColor(selected: Bool){
        if selected == true {
            label.textColor = UIColor.appleRed
        } else {
            label.textColor = UIColor.gainsboro
        }
    }
    
    
}
