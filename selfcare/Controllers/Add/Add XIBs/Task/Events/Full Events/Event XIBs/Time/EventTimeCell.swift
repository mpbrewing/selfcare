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
    var titles = [String]()
    var active = [Bool]()
    var titleString = "All-day"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupClockView()
        NotificationCenter.default.addObserver(self, selector: #selector(clockNotif(notification:)), name: .clock, object: nil)
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
    
    @objc func clockNotif(notification: NSNotification) {
        if let input = notification.userInfo?["state"] as? Bool {
            active[0] = input
            titles[0] = notification.userInfo?["title"] as? String ?? ""
            updateLabel()
        }
    }
    
    func updateLabel(){
        switch active[0] {
        case true:
            textInput(text: updateInput())
            toggleStyle(state: true)
        case false:
            textInput(text: "All-day")
            toggleStyle(state: false)
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
        titleString = label
        return label
    }
    
}

extension EventTimeCell{
    func setupClockView(){
        /*
         let screenSize = UIScreen.main.bounds
         let heightOffset = CGFloat(10)
         let widthOffset = CGFloat(10)
         let screenWidth = screenSize.width - widthOffset
         let screenHeight = screenSize.height - heightOffset
         */
        clockView = ClockViewClass(frame: CGRect(x: 0, y: 60, width: 414, height: 414))
        self.contentView.addSubview(clockView)
    }
}

extension Notification.Name {
    static let clock = Notification.Name("clock")
}
