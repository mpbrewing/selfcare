//
//  ViewEventCell.swift
//  selfcare
//
//  Created by Michael Brewington on 3/3/21.
//

import Foundation
import UIKit

class ViewEventsCell: UITableViewCell {
    
    @IBOutlet weak var bg: UIView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var selectView: UIView!
    
    var state = Bool()
    
    var images = [UIImage]()
    var event = Event(id: "", date: [Date()], time: [String](), repeating: [String:Any](), notify: [[String:Any]](), location: [String]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        bg.layer.cornerRadius = 10
        //bg.layer.borderColor = UIColor.appleBlue.cgColor
        bg.layer.borderColor = UIColor.gainsboro.cgColor
        bg.layer.borderWidth = 3
        
        selectView.layer.cornerRadius = 4
        //selectView.backgroundColor = UIColor.systemTeal
        selectView.backgroundColor = UIColor.appleBlue
        
        images = [#imageLiteral(resourceName: "eventCalendar"),#imageLiteral(resourceName: "event_icon"),#imageLiteral(resourceName: "eventRepeat"),#imageLiteral(resourceName: "eventNotify"),#imageLiteral(resourceName: "eventLocation")]
        let textArray = ["Event","Time","Repeat","Notify","Location"]
        for i in 0...images.count-1 {
            let imageArray = [image1,image2,image3,image4,image5]
            imageArray[i]?.image = images[i]
            imageArray[i]?.image = imageArray[i]?.image?.withRenderingMode(.alwaysTemplate)
            imageArray[i]?.tintColor = UIColor.gainsboro
            let labels = [label1,label2,label3,label4,label5]
            labels[i]?.textColor = UIColor.black
            labels[i]?.text = textArray[i]
            labels[i]?.alpha = 0.9
        }
        
        if state == true {
            selectView.isHidden = false
        } else {
            selectView.isHidden = true
        }
      
    }
    
    func updateLabels(){
        let labels = [label1,label2,label3,label4,label5]
        for i in 0...labels.count-1 {
            switchFunc(index: i)
        }
    }
    
    func switchFunc(index: Int){
        let labels = [label1,label2,label3,label4,label5]
        switch index {
        case 0:
            labels[index]?.text = dateLabel()
        case 1:
            labels[index]?.text = timeLabel()
        case 2:
            labels[index]?.text = repeatLabel()
        case 3:
            labels[index]?.text = notifyLabel()
        case 4:
            labels[index]?.text = locationLabel()
        default:
            break
        }
    }
    
    func dateLabel() -> String {
        var labelText = String()
        //print("date count: \(event.date.count)")
        if event.date.count > 0 {
            for i in 0...event.date.count-1{
                labelText.append("\(returnDateString(date: event.date[i]))")
                if i != event.date.count-1 {
                    labelText.append(" - ")
                }
            }
        }
        return labelText
    }
    
    func returnDateString(date: Date)->String{
        let formatter = DateFormatter()
        //formatter.dateFormat = "MMM d, yyyy"
        formatter.dateFormat = "MMM d"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    //Sort Time
    //No Time
    
    func timeLabel() -> String {
        var labelText = String()
        if event.time.count > 0 {
            for i in 0...event.time.count-1{
                if event.time[i] == "24:00" {
                    
                } else {
                    labelText.append(convertFromMilitary(time: "\(event.time[i])"))
                    if !event.time.contains("24:00") && i != event.time.count - 1 {
                        labelText.append(" - ")
                    }
                }
            }
            if labelText.isEmpty {
                labelText = "All-day"
            }
        }
        return labelText
    }
    
    func repeatLabel() -> String {
        let dict = event.repeating
        let index = dict["period"] as! Int
        let period = Int(index)
        let repeatData = ["Does not repeat","Every day","Every week","Every month","Every year"]
        return repeatData[period]
    }
    
    func notifyLabel() -> String{
        let array = event.notify
        var notify = "Does not notify"
        if array.count > 0 {
            notify = ""
            for i in 0...array.count - 1 {
                let dict = array[i]
                notify.append(returnNotify(dict: dict))
                if i != array.count - 1 {
                    notify.append(" • ")
                }
            }
        }
        return notify
    }
    
    func returnNotify(dict: [String:Any])->String{
        let period = ["Does not notify","m","h","d","w"]
        var notify = String()
        for (key, value) in dict.enumerated() {
           //print("Dictionary key \(key) - Dictionary value \(value)")
            print("key: \(key)")
            notify = "\(value.value)\(period[Int(value.key) ?? 0])"
            
        }
        return notify
    }
    
    func locationLabel() -> String{
        let array = event.location
        var label = String()
        if array.count > 0 {
            label = array[0]
        }
        return label
    }
    
    
    
}
