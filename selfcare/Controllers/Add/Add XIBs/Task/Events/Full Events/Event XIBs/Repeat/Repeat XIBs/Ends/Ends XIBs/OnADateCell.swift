//
//  OnADateCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/26/21.
//

//Send default date
//Default Date is first selected

import Foundation
import UIKit

class OnADateCell: UIView ,UIPickerViewDelegate, UIPickerViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var viewHandle: UIView!
    
     @IBOutlet weak var textBox: UIView!
     @IBOutlet weak var tabLabel: UILabel!
     @IBOutlet weak var datePicker: UIPickerView!
     @IBOutlet weak var dateCollection: UICollectionView!
     @IBOutlet weak var cancelButton: UIButton!
     @IBAction func toggleAction(_ sender: Any) {
        toggleStyle(state: false)
        updateDefaultString()
        selectedDates.removeAll()
        calendarDate.removeAll()
        setupCalendar()
        dateCollection.reloadData()
     }
    
    var monthData: [String] = [String]()
    var yearData: [Int] = [Int]()
    var month = 0
    var day = 0
    var year = 0
    var calendarDate = [CalendarDate]()
    var defaultLabel = String()
    var selectedDates = [CalendarDate]()
    let dateReuseID = "endsMiniNib"
    var eventDates: [Date] = [Date]() {
        didSet {
            //
        }
    }
    var currentDates: [CalendarDate] = [CalendarDate]() {
        didSet {
            //
            //Scroll Picker
            //dateCollection.reloadData()
            updateDefaultString()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        viewHandle = loadViewFromNib(name: "OnADateView")
        // use bounds not frame or it'll be offset
        viewHandle!.frame = bounds
        // Make the view stretch with containing view
        viewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(viewHandle!)
        handleInit()
    }
    
    func handleInit(){
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
        viewHandle.addGestureRecognizer(upSwipe)
        viewHandle.addGestureRecognizer(downSwipe)
    }
    
    @objc func upSwipeAction() {
       let row = datePicker.selectedRow(inComponent: 0) + 1
       if row < monthData.count {
           datePicker.selectRow(row, inComponent: 0, animated: true)
           month = row+1
           calendarDate.removeAll()
           setupCalendar()
           dateCollection.reloadData()
       }
    }
     
    @objc func downSwipeAction() {
       let row = datePicker.selectedRow(inComponent: 0) - 1
       if row > -1 {
           datePicker.selectRow(row, inComponent: 0, animated: true)
           month = row+1
           calendarDate.removeAll()
           setupCalendar()
           dateCollection.reloadData()
       }
    }
    
}
//Picker
extension OnADateCell {
    
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
//Collection
extension OnADateCell {
    
    func setupCollectionView(){
        self.dateCollection.register(UINib(nibName: "EndsMiniNib", bundle:nil), forCellWithReuseIdentifier: dateReuseID)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateReuseID, for: indexPath as IndexPath) as! EndsMiniNibCell
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
                    selectedDates.removeFirst()
                } else {
                    selectedDates.removeLast()
                }
            } else {
                selectedDates.removeFirst()
            }
            dateCollection.reloadData()
            updateLabel()
        } else {
            if calendarDate[indexPath.row].date > Date() || calendarDate[indexPath.row].compareDate(input: Date()) == true{
                if selectedDates.count < 1 {
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

//Calendar
extension OnADateCell {
    
    func calendarInit() {
        let date = Date()
        let components = date.get(.day, .month, .year)
        month = components.month!
        year = components.year!
        datePicker.selectRow((month-1), inComponent: 0, animated: true)
        let selectYear = abs(year-2021)
        datePicker.selectRow(selectYear, inComponent: 1, animated: true)
    }
    
    func setupCalendar() {
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
        var date = Date()
        if currentDates.count > 0 {
            date = currentDates[0].date
        }
        print("default: \(currentDates.count)")
        let dateString = formatter.string(from: date)
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
            toggleStyle(state: true)
        } else {
            updateDefaultString()
            toggleStyle(state: false)
        }
        passXibToRepeat()
    }
    
    func returnDateString(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    
}

extension OnADateCell {
    
    func passXibToRepeat()
    {
        let date = returnDate()
        let passState = ["index":0,"date":date] as [String : Any]
        NotificationCenter.default.post(name: .xibToEnds, object: nil,userInfo: passState)
    }
    
    func returnDate() -> Date{
        if selectedDates.count > 0 {
            return selectedDates[0].date
        } else {
            //Update default
            return Date()
        }
    }
    
}
