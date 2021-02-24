//
//  EventTimeCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit

class EventTimeCell: UICollectionViewCell {
    
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBAction func cancelAction(_ sender: Any) {
        //clockView.resetClock()
        clockView.state = false
        clockView.updateState()
    }
    
    var state = false
    var clockView = ClockViewClass()
    var clockView2 = ClockViewClass()
    var miniClockView = MiniClock()
    var miniClockView2 = MiniClock()
    var titles = [String]()
    var active = [Bool]()
    var titleString = "All-day"
    var modify = false
    var hourArray = [Int]()
    var minuteArray = [Int]()
    var compareArray = [Int]()
    var militaryTime = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupClockView()
        setupMiniClockView()
        updateModify()
        NotificationCenter.default.addObserver(self, selector: #selector(timeNotif(notification:)), name: .xibToTime, object: nil)
    }
    
    func setupStyle(){
        textBox.layer.cornerRadius = 8
        cancel.layer.cornerRadius = 8
        textBox.layer.backgroundColor = UIColor.lightGains.cgColor
        cancel.backgroundColor = UIColor.gainsboro
        let cancelButtonImage = #imageLiteral(resourceName: "cancel")
        cancel.setImage(cancelButtonImage.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        toggleStyle(state: state)
        textInput(text: titleString)
        titles = Array(repeating: "", count: 2)
        active = Array(repeating: false, count: 2)
        hourArray = Array(repeating: 0, count: 2)
        minuteArray = Array(repeating: 0, count: 2)
        compareArray = Array(repeating: 0, count: 2)
        militaryTime = Array(repeating: "24:00", count: 2)
    }
    
    func toggleStyle(state: Bool){
        switch state {
        case true:
            title.frame = CGRect(x: 20, y: 6, width: 328, height: 46)
            cancel.isHidden = false
            textBox.isHidden = false
            title.textColor = UIColor.darkGray
        case false:
            title.frame = CGRect(x: 12, y: 6, width: 390, height: 46)
            cancel.isHidden = true
            textBox.isHidden = true
            title.textColor = UIColor.gainsboro
        }
    }
    
    func textInput(text: String){
        title.text = text
    }
    
    @objc func timeNotif(notification: NSNotification) {
        if let input = notification.userInfo?["input"] as? Int {
            if input == 0 {
                clockNotif(notification: notification)
            } else {
                miniNotif(notification: notification)
            }
        }
    }
    
    func clockNotif(notification: NSNotification) {
        if let input = notification.userInfo?["state"] as? Bool {
            let count = notification.userInfo?["count"] as? Int ?? 0
            active[count] = input
            titles[count] = notification.userInfo?["title"] as? String ?? ""
            hourArray[count] = notification.userInfo?["hour"] as? Int ?? 12
            minuteArray[count] = notification.userInfo?["minute"] as? Int ?? 0
            compareArray[count] = notification.userInfo?["compare"] as? Int ?? 0
            militaryTime[count] = notification.userInfo?["military"] as? String ?? ""
            updateMilitary()
            updateLabel(count: count)
            let send =  notification.userInfo?["send"] as? Bool ?? true
            verifyPass(send: send)
        }
    }
    
    func miniNotif(notification: NSNotification) {
        if let input = notification.userInfo?["count"] as? Int {
            switchMiniDown(count: input)
            //Pass Hour and Minute
        }
    }
    
    func updateMiniClock(count: Int,view: MiniClock){
        view.updateMiniClock(hour: hourArray[count], minute: minuteArray[count])
    }
    
    func switchMiniDown(count: Int){
        if count == 0 {
            clockView.isHidden = true
            clockView2.isHidden = false
            miniClockView.isHidden = true
            miniClockView2.isHidden = false
            updateMiniClock(count: 0, view: miniClockView2)
        } else {
            clockView.isHidden = false
            clockView2.isHidden = true
            miniClockView.isHidden = false
            miniClockView2.isHidden = true
            updateMiniClock(count: 1, view: miniClockView)
        }
    }
    
    func updateLabel(count: Int){
        switch active[count] {
        case true:
            textInput(text: updateInput())
            if count == 0 {
                toggleStyle(state: true)
                miniClockView.isHidden = false
            }
        case false:
            if count == 0 {
                textInput(text: "All-day")
                toggleStyle(state: false)
                miniClockView.isHidden = true
            } else {
                textInput(text: updateInput())
            }
        }
        //passEventTime()
    }
    
    func returnRange(input: String) -> String{
        if active[0] == true && active[1] == true {
            if compareArray[0] < compareArray[1] {
                //let array = [militaryTime[0],militaryTime[1]]
                //militaryTime = array
                let label = "\(titles[0]) - \(titles[1])"
                return label
            } else {
                //let array = [militaryTime[1],militaryTime[0]]
                //militaryTime = array
                let label = "\(titles[1]) - \(titles[0])"
                return label
            }
        } else {
            return input
        }
    }
    
    func updateInput()->String{
        var label = ""
        for i in 0...1{
            if active[i] == true {
                if i == 1 {
                    label.append(" - ")
                }
                label.append("\(titles[i])")
            }
        }
        titleString = returnRange(input: label)
        return titleString
    }
    
    func updateModify(){
        if modify == true {
            //miniClockView.isHidden = false
        } else {
            updateLabel(count: 0)
        }
    }
    
}

extension EventTimeCell{
    func setupClockView(){
        clockView = ClockViewClass(frame: CGRect(x: 0, y: 60, width: 414, height: 414))
        clockView2 = ClockViewClass(frame: CGRect(x: 0, y: 60, width: 414, height: 414))
        self.contentView.addSubview(clockView)
        self.contentView.addSubview(clockView2)
        clockView2.isHidden = true
        clockView2.count = 1
    }
    func setupMiniClockView(){
        miniClockView = MiniClock(frame: CGRect(x: 240, y: 472, width: 150, height: 150))
        miniClockView2 = MiniClock(frame: CGRect(x: 24, y: 472, width: 150, height: 150))
        self.contentView.addSubview(miniClockView)
        self.contentView.addSubview(miniClockView2)
        miniClockView.alpha = 0.5
        miniClockView2.alpha = 0.5
        miniClockView2.isHidden = true
        miniClockView2.count = 1
    }
}

//Handle and Pass Event Time
extension EventTimeCell {
        
    func sortMilitary()->[String]{
        var hold = militaryTime
        if active[0] == true && active[1] == true {
            if compareArray[0] < compareArray[1] {
                let array = [militaryTime[0],militaryTime[1]]
                hold = array
            } else {
                let array = [militaryTime[1],militaryTime[0]]
                hold = array
            }
        }
        return hold
    }
    
    func verifyPass(send: Bool){
        if send == true {
            passEventTime()
        } else {
            
        }
    }
    
    func updateMilitary(){
        if active[0] == false {
            militaryTime = ["24:00","24:00"]
        }
    }
    
    
    func passEventTime(){
        let holdMilitary = sortMilitary()
        //militaryTime
        //print("0: \(militaryTime[0])")
        //print("1: \(militaryTime[1])")
        let notif = ["index":1,"time":holdMilitary] as [String : Any]
        NotificationCenter.default.post(name: .addEventXib, object: nil,userInfo: notif)
    }
    
}
