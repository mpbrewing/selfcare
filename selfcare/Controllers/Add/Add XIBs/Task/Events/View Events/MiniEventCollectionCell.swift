//
//  MiniEventCollectionCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/21/21.
//

import Foundation
import UIKit

class MiniEventCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var divider2: UIView!
    @IBOutlet weak var divider3: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    var images = [UIImage]()
    var event = Event(date: [Date()], time: [String](), repeating: [String:Any](), notify: [[String:Any]](), location: [String]())
    //Update Defaults
    
    var status = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        bg.layer.cornerRadius = 10
        bg.layer.borderColor = UIColor.appleBlue.cgColor
        bg.layer.borderWidth = 3
        for view in [divider,divider2,divider3] {
            view?.alpha = 0
            view?.layer.cornerRadius = 2
            view?.backgroundColor = UIColor.silver
        }
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
        updateFormat()
    }
    
    func updateFormat(){
        print(event.location.count)
        if event.location.count > 0 {
            image5.isHidden = true
            label5.isHidden = true
            let labelArray = [CGRect(x: 39, y: 25, width: 138, height: 24),CGRect(x: 211, y: 25, width: 138, height: 24),CGRect(x: 39, y: 74, width: 138, height: 24),CGRect(x: 211, y: 74, width: 138, height: 24),CGRect(x: 39, y: 82, width: 312, height: 24)]
            let imageArray = [CGRect(x: 12, y: 24, width: 20, height: 20),CGRect(x: 185, y: 24, width: 20, height: 20),CGRect(x: 12, y: 74, width: 20, height: 20),CGRect(x: 185, y: 74, width: 20, height: 20),CGRect(x: 12, y: 82, width: 20, height: 20)]
            let labels = [label1,label2,label3,label4,label5]
            let imageViews = [image1,image2,image3,image4,image5]
            for i in 0...labels.count - 1 {
                labels[i]?.frame = labelArray[i]
                imageViews[i]?.frame = imageArray[i]
            }
        } else {
            image5.isHidden = false
            label5.isHidden = false
            let labelArray = [CGRect(x: 39, y: 12, width: 138, height: 24),CGRect(x: 211, y: 12, width: 138, height: 24),CGRect(x: 39, y: 46, width: 138, height: 24),CGRect(x: 211, y: 46, width: 138, height: 24),CGRect(x: 39, y: 82, width: 312, height: 24)]
            let imageArray = [CGRect(x: 12, y: 11, width: 20, height: 20),CGRect(x: 185, y: 11, width: 20, height: 20),CGRect(x: 12, y: 46, width: 20, height: 20),CGRect(x: 185, y: 46, width: 20, height: 20),CGRect(x: 12, y: 82, width: 20, height: 20)]
            let labels = [label1,label2,label3,label4,label5]
            let imageViews = [image1,image2,image3,image4,image5]
            for i in 0...labels.count - 1 {
                labels[i]?.frame = labelArray[i]
                imageViews[i]?.frame = imageArray[i]
            }
        }
    }
    
    func updateStatus(){
        //let colors = [UIColor.gainsboro,UIColor.systemRed,UIColor.systemYellow,UIColor.systemGreen]
        //let color = colors[status]
        //bg.layer.borderColor = color.cgColor
        //bg.layer.borderColor = UIColor.systemTeal.cgColor
        bg.layer.borderColor = UIColor.gainsboro.cgColor
        //bg.layer.borderColor = UIColor.appleBlue.cgColor
        //bg.alpha = 0.6
    }
    
    func updateLabels(){
        let labels = [label1,label2,label3,label4,label5]
        for i in 0...labels.count-1 {
            switchFunc(index: i)
        }
        updateStatus()
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
