//
//  EventRepeatCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

//Pass in date and add excluded dates

import Foundation
import UIKit
class EventRepeatCell: UICollectionViewCell,UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var repeatPicker: UIPickerView!
    @IBOutlet weak var repeatTableView: UITableView!
    
    @IBAction func dismissAction(_ sender: Any) {
        toggleStyle(state: false)
        defaultLabel = repeatData[0]
        updateDefaultString()
        selection = 0
        repeatPicker.selectRow(0, inComponent: 0, animated: true)
        repeatTableView.reloadData()
    }
    
    var repeatData: [String] = [String]()
    var defaultLabel = String()
    var selection = 0
    var eventRepeat = [String:Any]()
    var ends = [String:Any]()
    var excluded = [Date]()
    var eventSelection = [String:Any]()
    var week = [Bool]()
    var month = Int()
    var eventDates = [Date]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPickerData()
        setupStyle()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(setEventRepeat(notification:)), name: .xibToRepeat, object: nil)
    }
    
    func setupStyle(){
        textBox.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        textBox.layer.backgroundColor = UIColor.lightGains.cgColor
        cancelButton.backgroundColor = UIColor.gainsboro
        let cancelButtonImage = #imageLiteral(resourceName: "cancel")
        cancelButton.setImage(cancelButtonImage.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        toggleStyle(state: false)
        defaultLabel = repeatData[selection]
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
    
}

extension EventRepeatCell {
    
    func setupPickerData(){
        repeatPicker.delegate = self
        repeatPicker.dataSource = self
        repeatData = ["Does not repeat","Every day","Every week","Every month","Every year"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.textColor = .black
        label.textAlignment = .center
        label.text = repeatData[row]
        label.font = UIFont (name: "Nexa-Bold", size: 30)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            defaultLabel = repeatData[row]
            toggleStyle(state: false)
        } else {
            defaultLabel = repeatData[row]
            toggleStyle(state: true)
        }
        selection = row
        updateDefaultString()
        pickerChange()
        repeatTableView.reloadData()
    }
    
    func updateDefaultString(){
        tabLabel.text = defaultLabel
    }
    
}

extension EventRepeatCell {
    
    func setupTableView()
    {
        //Selection
        repeatTableView.register(UINib(nibName: "RepeatSelection", bundle: nil), forCellReuseIdentifier: "repeatSelection")
        //Week
        repeatTableView.register(UINib(nibName: "RepeatWeek", bundle: nil), forCellReuseIdentifier: "repeatWeek")
        //Month
        repeatTableView.register(UINib(nibName: "RepeatMonth", bundle: nil), forCellReuseIdentifier: "repeatMonth")
        //
        repeatTableView.delegate = self
        repeatTableView.dataSource = self
        //
        repeatTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return switchRowsInSection()
   }
    
    func switchRowsInSection() -> Int{
        switch selection {
        case 0:
            return 0
        case 1,4:
            return 1
        case 2,3:
            return 2
        default:
            return 0
        }
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //Switch: Week, Month, Selection
     return switchCellForRowAt(tableView: tableView, indexPath: indexPath)
   }
    
    func switchCellForRowAt(tableView: UITableView ,indexPath: IndexPath) -> UITableViewCell {
        switch selection {
        case 1,4:
            return returnSelectionCell(tableView: tableView, indexPath: indexPath)
        case 2,3:
            switch indexPath.row {
            case 0:
                return switchSelectedCell(tableView: tableView, indexPath: indexPath)
            case 1:
                return returnSelectionCell(tableView: tableView, indexPath: indexPath)
            default:
                return returnSelectionCell(tableView: tableView, indexPath: indexPath)
            }
        default:
            return returnSelectionCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func returnSelectionCell(tableView: UITableView ,indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "repeatSelection", for: indexPath) as! RepeatSelectionCell
        return cell
    }
    
    func switchSelectedCell(tableView: UITableView ,indexPath: IndexPath) -> UITableViewCell {
        switch selection {
        case 2: //Week
            let cell = tableView.dequeueReusableCell(withIdentifier: "repeatWeek", for: indexPath) as! RepeatWeekCell
            return cell
        case 3: //Month
            let cell = tableView.dequeueReusableCell(withIdentifier: "repeatMonth", for: indexPath) as! repeatMonthCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "repeatWeek", for: indexPath) as! RepeatWeekCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return switchHeight(indexPath: indexPath)
    }
    
    func switchHeight(indexPath: IndexPath) -> CGFloat{
        switch selection {
        case 1,4:
            return 200
        case 2,3:
            switch indexPath.row {
            case 0:
                return switchSelectedheight()
            case 1:
                return 200
            default:
                return 200
            }
        default:
            return 200
        }
    }
    
    func switchSelectedheight() -> CGFloat{
        switch selection {
        case 2:
            return 75
        case 3:
            return 100 //Determine Height from selected date
        default:
            return 200
        }
    }
    
}

//Handle and Pass Event Repeat
extension EventRepeatCell {
    
    ///repeat: [String:Any]()
    //^
    //ends: [String:Any]()
    // -> selection: Int()
    // -> date: Date()
    // -> occur: Int()
    //excluded: [Date]() (unfinished)
    //period: Int() *ie selection
    //selected: [String:Any]()
    // -> *week: [Bool]
    // -> *month: Int
    
    func passEventRepeat(){
        //Event Repeat Defaults
        let notif = ["index":2,"repeat":eventRepeat] as [String : Any]
        NotificationCenter.default.post(name: .addEventXib, object: nil,userInfo: notif)
    }
    
    //Receive
    @objc func setEventRepeat(notification: NSNotification) {
        if let index = notification.userInfo?["index"] as? Int {
            switchNotif(index: index,notif: notification)
            passEventRepeat()
        }
    }
    
    func switchNotif(index: Int,notif: NSNotification){
        switch index {
        case 0: //Ends and Excluded
            //print("0")
            notifEnds(notif: notif)
        case 1: //Week
            //print("1")
            notifWeek(notif: notif)
        case 2: //Month
            //print("2")
            notifMonth(notif: notif)
        default:
            break
        }
        notifSelected()
        notifRepeat()
    }
    //ends and excluded
    func notifEnds(notif: NSNotification){
        ends = notif.userInfo?["ends"] as? [String:Any] ?? [String:Any]()
        //excluded =  notif.userInfo?["excluded"] as? [Date] ?? [Date]()
    }
    //week
    func notifWeek(notif: NSNotification){
        week = notif.userInfo?["week"] as? [Bool] ?? [Bool]()
    }
    //month
    func notifMonth(notif: NSNotification){
        month = notif.userInfo?["month"] as? Int ?? Int()
    }
    //func to setup selected
    func notifSelected(){
        eventSelection = ["week":week,"month":month]
    }
    //func to setup repeat
    func notifRepeat(){
        eventRepeat = ["ends":ends,"excluded":excluded,"period":selection,"selected":eventSelection]
    }
    func pickerChange(){
        notifRepeat()
        notifSelected()
        passEventRepeat()
    }
}
