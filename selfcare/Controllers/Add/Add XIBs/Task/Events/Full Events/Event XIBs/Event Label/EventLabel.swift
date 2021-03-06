//
//  EventLabel.swift
//  selfcare
//
//  Created by Michael Brewington on 1/19/21.
//

import Foundation
import UIKit

class EventLabel: UITableViewCell{
    
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var title: UILabel!
    
    var state = false
    var row = Int()
    
    @IBAction func cancelAction(_ sender: Any) {
        //???
        passCancel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        textBox.layer.cornerRadius = 8
        cancel.layer.cornerRadius = 8
        textBox.layer.backgroundColor = UIColor.lightGains.cgColor
        cancel.backgroundColor = UIColor.gainsboro
        let cancelButtonImage = #imageLiteral(resourceName: "cancel")
        cancel.setImage(cancelButtonImage.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        toggleStyle(state: state)
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
    
    func cellInput(text: String, bool: Bool){
        title.text = text
        toggleStyle(state: bool)
        if text == "Does not notify" {
            title.textColor = UIColor.gainsboro
        } else {
            title.textColor = UIColor.darkGray
        }
    }
    
}

//Handle Notification Label Cancel Action
extension EventLabel {
    
    func passCancel(){
        let passState = ["state":0,"row":row]
        NotificationCenter.default.post(name: .xibToNotify, object: nil,userInfo: passState)
    }
    
}
