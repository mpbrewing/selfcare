//
//  NotifyPicker.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class NotifyPicker: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var label: UILabel!
    var labelString = String()
    
    @IBAction func addButtonAction(_ sender: Any) {
        if periodSelection != 0 {
        passPicker(add: true)
        }
    }
    
    func passPicker(add: Bool){
        updateLabel()
        //let eventNotify = [periodSelection,timeSelection]
        let eventNotify = ["\(periodSelection)":timeSelection]
        let passState = ["state":1,"period":periodSelection,"time":timeSelection,"label":labelString,"add":add,"eventNotify":eventNotify] as [String : Any]
        NotificationCenter.default.post(name: .xibToNotify, object: nil,userInfo: passState)
    }
    
    func updateLabel(){
        if periodSelection == 0 {
            labelString = "Does not notify"
        } else {
            labelString = "Notify \(timeSelection) \(periodArray[periodSelection]) before"
        }
    }
    
    var periodArray = [String]()
    var minuteArray = [Int]()
    var hourArray = [Int]()
    var dayArray = [Int]()
    var weekArray = [Int]()
    var doesNotArray: [Int] = []
    var holdArray = [Int]()
    var pickerArray = [[Int]]()
    
    var timeSelection = 0
    var periodSelection = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPicker()
        setupStyle()
    }
    
    func setupStyle(){
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 3
        bg.layer.borderColor = UIColor.gainsboro.cgColor
    }
    
    func setupPicker(){
        picker.delegate = self
        picker.dataSource = self
        periodArray = ["Does not notify","minutes","hours","days","weeks"]
        minuteArray = Array(0...60)
        hourArray = Array(0...24)
        dayArray = Array(0...28)
        weekArray = Array(0...4)
        holdArray = doesNotArray
        pickerArray = [doesNotArray,minuteArray,hourArray,dayArray,weekArray]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return holdArray.count
        case 1:
            return periodArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.textColor = .black
        label.textAlignment = .center
        if component == 0 {
            label.text = "\(holdArray[row])"
        } else {
            label.text = periodArray[row]
        }
        label.font = UIFont (name: "Nexa-Bold", size: 24)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if holdArray.count >= row {
                timeSelection = holdArray[row]
            }
        } else {
            periodSelection = row
            holdArray = pickerArray[row]
            picker.reloadComponent(0)
            updateTimeSelection()
        }
        passPicker(add: false)
    }
    
    func updateTimeSelection(){
        if periodSelection != 0 {
            if timeSelection > holdArray.last! {
                timeSelection = holdArray.last!
            }
        }
    }
    
    func resetPicker(bool: Bool){
        if bool == true {
            periodSelection = 0
            holdArray = pickerArray[0]
            timeSelection = 0
            picker.selectRow(0, inComponent: 1, animated: false)
            picker.reloadComponent(0)
            updateLabel()
            passReset()
        } else {
            
        }
    }
    
    func passReset(){
        let passState = ["state":2,"label":labelString] as [String : Any]
        NotificationCenter.default.post(name: .xibToNotify, object: nil,userInfo: passState)
    }
    
}

