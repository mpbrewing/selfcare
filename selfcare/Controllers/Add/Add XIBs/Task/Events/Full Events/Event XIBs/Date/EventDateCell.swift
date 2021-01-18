//
//  EventDateCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit
class EventDateCell: UICollectionViewCell,UIPickerViewDelegate, UIPickerViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var dateCollection: UICollectionView!
    
    var monthData: [String] = [String]()
    var yearData: [Int] = [Int]()
    let dateReuseID = "dateNib"
    var month = 0
    var day = 0
    var year = 0
    var calendarDate = [CalendarDate]()
    var defaultLabel = String()
    var selectedDates = [CalendarDate]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupPickerData()
        calendarInit()
        setupCalendar()
        setupCollectionView()
        setupSwipe()
    }
    
    func setupStyle(){
        textBox.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        textBox.layer.backgroundColor = UIColor.lightGains.cgColor
        cancelButton.backgroundColor = UIColor.gainsboro
        let cancelButtonImage = #imageLiteral(resourceName: "cancel")
        cancelButton.setImage(cancelButtonImage.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        toggleStyle(state: false)
        updateDefaultString()
        //tabLabel.text = "Fri, Jan 15"
    }
    
    func toggleStyle(state: Bool){
        switch state {
        case true:
            tabLabel.frame = CGRect(x: 20, y: 6, width: 328, height: 46)
            cancelButton.isHidden = false
            textBox.isHidden = false
            tabLabel.textColor = UIColor.darkGray
        case false:
            tabLabel.frame = CGRect(x: 12, y: 6, width: 390, height: 46)
            cancelButton.isHidden = true
            textBox.isHidden = true
            tabLabel.textColor = UIColor.gainsboro
        }
    }
    
     func setupSwipe(){
         let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeAction))
         let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downSwipeAction))
         upSwipe.direction = .up
         downSwipe.direction = .down
         contentView.addGestureRecognizer(upSwipe)
         contentView.addGestureRecognizer(downSwipe)
     }
     
     @objc func upSwipeAction() {
        let row = datePicker.selectedRow(inComponent: 0) + 1
        if row < monthData.count {
            datePicker.selectRow(row, inComponent: 0, animated: true)
            month = row+1
            calendarDate.removeAll()
            setupCalendar()
            dateCollection.reloadData()
        } //change year
     }
      
     @objc func downSwipeAction() {
        let row = datePicker.selectedRow(inComponent: 0) - 1
        if row > -1 {
            datePicker.selectRow(row, inComponent: 0, animated: true)
            month = row+1
            calendarDate.removeAll()
            setupCalendar()
            dateCollection.reloadData()
        } //change year
     }
     
    //save month and year
    //swipe to change year at 0,11
    //pull correct calendar dates
    //change calendar with picker selections
    //change style of previous dates, current dates, and future dates
    //make previous dates non-selectable
    //make dates selectable
    //change label text with selected dates
    //get current month, year
    
}

extension EventDateCell {
    
    func setupPickerData(){
        datePicker.delegate = self
        datePicker.dataSource = self
        monthData = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        yearData = Array(2021...2121)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return monthData.count
        case 1:
            return yearData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        //label.font = UIFont (name: "Nexa-Bold", size: 30)
        label.textColor = .black
        label.textAlignment = .center
        if component == 0 {
            label.text =  monthData[row]
            label.font = UIFont (name: "Nexa-Bold", size: 30)
        } else {
            label.text = "\(yearData[row])"
            label.font = UIFont (name: "Nexa-Bold", size: 28)
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            month = row+1
            calendarDate.removeAll()
            setupCalendar()
            dateCollection.reloadData()
        case 1:
            year = yearData[row]
            calendarDate.removeAll()
            setupCalendar()
            dateCollection.reloadData()
        default:
            break
        }
    }
    
}

extension EventDateCell {
    
    func setupCollectionView(){
        self.dateCollection.register(UINib(nibName: "MiniDate", bundle:nil), forCellWithReuseIdentifier: dateReuseID)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateReuseID, for: indexPath as IndexPath) as! MiniDateCell
        //cell.date.text = "\(indexPath.row)"
        cell.date.text = "\(calendarDate[indexPath.row].day)"
        cell.isSelected(bool: calendarDate[indexPath.row].isSelected, style: calendarDate[indexPath.row].style)
        if selectedDates.count == 2 {
            if calendarDate[indexPath.row].date > selectedDates[0].date && calendarDate[indexPath.row].date < selectedDates[1].date {
                if calendarDate[indexPath.row].compareDate(input: selectedDates[0].date) == false && calendarDate[indexPath.row].compareDate(input: selectedDates[1].date) == false {
                    cell.isBetween()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("You selected cell #\(indexPath.row)!")
        if calendarDate[indexPath.row].isSelected == true {
            calendarDate[indexPath.row].toggleIsSelected()
            if selectedDates.count > 1 {
                if  calendarDate[indexPath.row].compareDate(input: selectedDates[0].date) == true {
                    //print("index: \(0)")
                    selectedDates.removeFirst()
                } else {
                    //print("index: \(1)")
                    selectedDates.removeLast()
                }
            } else {
                selectedDates.removeFirst()
            }
            dateCollection.reloadData()
            updateLabel()
        } else {
            if calendarDate[indexPath.row].date > Date() || calendarDate[indexPath.row].compareDate(input: Date()) == true{
                if selectedDates.count < 2 {
                    calendarDate[indexPath.row].toggleIsSelected()
                    selectedDates.append(calendarDate[indexPath.row])
                    selectedDates = selectedDates.sorted(by: {
                        $0.date.compare($1.date) == .orderedAscending
                    })
                    dateCollection.reloadData()
                    updateLabel()
                }
            }
        }
        //print(selectedDates.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 7)
        return CGSize(width: width, height: width)
   }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

extension EventDateCell {
    
    func calendarInit() {
        let date = Date()
        let components = date.get(.day, .month, .year)
        month = components.month!
        year = components.year!
        datePicker.selectRow((month-1), inComponent: 0, animated: true)
    }
    
    func setupCalendar() {
        //Get first day of week in first week of month
        //Get remaining days
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "\(year)/\(month)/01")
        let components = calendar.dateComponents([.year, .month], from: date!)
        let startOfMonth = calendar.date(from: components)
        var dateLoop = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfMonth!))
        for _ in 0...41{
            let component = dateLoop!.get(.day,.month,.year)
            let newDate = CalendarDate(date: dateLoop!, month: component.month!, day: component.day!, year: component.year!, isSelected: returnIsSelected(date: dateLoop!), style: returnStyle(date: dateLoop!))
            calendarDate.append(newDate)
            dateLoop = Calendar.current.date(byAdding: .day, value: 1, to: dateLoop!)
        }
    }
    
    func returnStyle(date: Date)->Int{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let today = formatter.string(from: Date())
        let holdDate = formatter.string(from: date)
        if today == holdDate{
            return 0
        } else if date > Date() {
            let components = date.get(.day, .month, .year)
            if month == components.month! {
                return 1
            } else {
                return 2
            }
        } else {
           return 3
        }
    }
    
    func updateDefaultString(){
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        let dateString = formatter.string(from: Date())
        defaultLabel = dateString
        tabLabel.text = defaultLabel
    }
    
    func returnIsSelected(date: Date)->Bool{
        if selectedDates.count > 0 {
            for i in 0...selectedDates.count-1 {
                if selectedDates[i].compareDate(input: date) == true {
                    return true
                }
            }
            return false
        } else {
            return false
        }
    }
    
    func updateLabel(){
        if selectedDates.count > 0 {
            if selectedDates.count == 1 {
                tabLabel.text = "\(returnDateString(date: selectedDates[0].date))"
            } else {
                tabLabel.text = "\(returnDateString(date: selectedDates[0].date)) - \(returnDateString(date: selectedDates[1].date))"
            }
        } else {
            updateDefaultString()
        }
    }
    
    func returnDateString(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}

/*
 //let formatter = DateFormatter()
 //formatter.dateStyle = .full
 //let dateString = formatter.string(from: sunday!)
 //print(dateString)
 
 */
