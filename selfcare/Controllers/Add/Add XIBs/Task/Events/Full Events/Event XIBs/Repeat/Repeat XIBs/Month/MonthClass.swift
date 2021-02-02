//
//  MonthClass.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class MonthClass: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var monthArray = [String]()
    var dayOfWeek = String()
    var weekNumber = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dayOfWeek = "Sunday"
        weekNumber = "fourth"
        monthArray = ["On the same day each month","On every \(weekNumber) \(dayOfWeek)","On every last \(dayOfWeek)","On the last day of the month"]
    }
    
    func updateLabel(index: Int, selected: Bool){
        label.text = monthArray[index]
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
