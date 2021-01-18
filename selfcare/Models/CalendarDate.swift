//
//  CalendarDate.swift
//  selfcare
//
//  Created by Michael Brewington on 1/18/21.
//

import Foundation

class CalendarDate {
    
    var date: Date
    var month: Int
    var day: Int
    var year: Int
    var isSelected: Bool
    var style: Int
    
    init(date: Date, month: Int, day: Int, year: Int, isSelected: Bool, style: Int) {
        self.date = date
        self.month = month
        self.day = day
        self.year = year
        self.isSelected = isSelected
        self.style = style
    }
    
    func toggleIsSelected(){
        self.isSelected = !isSelected
    }
    
    func compareDate(input: Date)->Bool{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let inputDate = formatter.string(from: input)
        let holdDate = formatter.string(from: date)
        if inputDate == holdDate {
            return true
        } else {
            return false
        }
    }
    
}
