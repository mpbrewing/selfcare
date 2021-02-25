//
//  repeatMonthCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class repeatMonthCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthTableView: UITableView!
    
    var state = 2
    var selectedArray = [Bool]()
    var selection = 0
    var eventDates: [Date] = [Date]() {
        didSet {
            //
            updateSelection()
            monthTableView.reloadData()
        }
    }
    var dayOfWeek = Int()
    var weekNumber = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        //updateSelection()
        selectedArray = Array(repeating: false, count: 4)
        selectedArray[selection] = true
    }
    
    func updateSelection(){
        var date = Date()
        if eventDates.count > 0 {
            date = eventDates[0]
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([ .weekday,.weekOfMonth], from: date)
        var weekDay = components.weekday ?? 0
        if weekDay >= 0 {
            weekDay = weekDay - 1
        }
        dayOfWeek = weekDay
        let weekOfMonth = components.weekOfMonth ?? 0
        weekNumber = weekOfMonth
        //print(weekNumber)
        //print(dayOfWeek)
        state = updateState()
    }
    
    func updateState()->Int{
        var date = Date()
        if eventDates.count > 0 {
            date = eventDates[0]
        }
        let calendar = Calendar.current
        var components = calendar.dateComponents([ .weekday,.weekOfMonth,.year, .month], from: date)
        //let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month = components.month! + 1
        components.day = 1
        components.day = components.day! - 1
        let lastDay = Calendar.current.date(from: components)!
        //let other = calendar.dateComponents([ .weekday,.weekOfMonth,.year, .month], from: lastDay)
       // let lastWeek = other.weekOfMonth!
        //print("lastDay: \(lastDay)")
        //print("lastDay: \(lastWeek)")
        if returnDateString(date: date) == returnDateString(date: lastDay) {
            return 4
        } else if returnLastWeek(input: lastDay) {
            return 3
        } else {
            return 2
        }
        //else - 2
        //last week - 3
        //last day of month - 4
    }
    
    func returnLastWeek(input: Date)->Bool{
        var date = input
        let cal = Calendar.current
        date = cal.startOfDay(for: date)
        var dates = [Date]()
        var days = [Int]()
        for _ in 1 ... 7 {
            let day = cal.component(.day, from: date)
            days.append(day)
            dates.append(date)
            date = cal.date(byAdding: .day, value: -1, to: date)!
        }
        //print(days)
        var current = Date()
        if eventDates.count > 0 {
            current = eventDates[0]
        }
        if dates.contains(current) {
            return true
        } else {
            return false
        }
    }
    
    func returnDateString(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func setupTableView()
    {
        //Month Cell
        monthTableView.register(UINib(nibName: "MonthCell", bundle: nil), forCellReuseIdentifier: "monthCell")
        //
        monthTableView.delegate = self
        monthTableView.dataSource = self
        //
        monthTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "monthCell", for: indexPath) as! MonthClass
      cell.dayOfWeek = dayOfWeek
      cell.weekNumber = weekNumber
      cell.updateLabel(index: indexPath.row, selected: selectedArray[indexPath.row])
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedArray[indexPath.row] == true {
            
        } else {
            selectedArray = Array(repeating: false, count: 4)
            selectedArray[indexPath.row] = !selectedArray[indexPath.row]
            selection = indexPath.row
            passXibToRepeat()
            monthTableView.reloadData()
        }
        
    }
    
    
}
//2
//
extension repeatMonthCell {
    
    func passXibToRepeat()
    {
        let passState = ["index":2,"month":selection] as [String : Any]
        NotificationCenter.default.post(name: .xibToRepeat, object: nil,userInfo: passState)
    }
    
}
