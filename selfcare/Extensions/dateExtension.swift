//
//  dateExtension.swift
//  selfcare
//
//  Created by Michael Brewington on 1/18/21.
//

import Foundation
import UIKit

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

//https://stackoverflow.com/questions/53356392/how-to-get-day-and-month-from-date-type-swift-4
