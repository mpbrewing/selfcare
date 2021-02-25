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
    var dayOfWeek = Int()
    var weekNumber = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //dayOfWeek = "Sunday"
        //weekNumber = "fourth"
        //monthArray = ["On the same day each month","On every \(weekNumber) \(dayOfWeek)","On every last \(dayOfWeek)","On the last day of the month"]
    }
    
    func updateLabel(index: Int, selected: Bool){
        monthArray = ["On the same day each month","On every \(returnWeekNumber(week: weekNumber-1)) \(returnDayOfWeek(day: dayOfWeek))","On every last \(returnDayOfWeek(day: dayOfWeek))","On the last day of the month"]
        label.text = monthArray[index]
        updateColor(selected: selected)
    }
    
    func returnWeekNumber(week: Int)->String{
        let ordinal = ["first","second","third","fourth","fifth","sixth"]
        return ordinal[week]
    }
    
    func returnDayOfWeek(day: Int)->String{
        let days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        return days[day]
    }
    
    func updateColor(selected: Bool){
        if selected == true {
            label.textColor = UIColor.appleRed
        } else {
            label.textColor = UIColor.gainsboro
        }
    }
    
}
