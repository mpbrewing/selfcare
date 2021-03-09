//
//  FullViewTitleCell.swift
//  selfcare
//
//  Created by Michael Brewington on 3/8/21.
//

import Foundation
import UIKit
//import AVFoundation

class FullViewTitleCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var status: UIButton!
    @IBAction func StatusAction(_ sender: Any) {
        if index > 0 {
            tapStatus()
        }
    }
    
    var index = Int()
    var input = Int()
    var color = UIColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        status.layer.cornerRadius = 8
        //updateType()
    }
    
    func setDetails(emoji: String,name:String) {
        self.emoji.text = emoji
        title.text = name
    }
    
    func updateType(){
        if index > 0 {
            switchStatus()
        } else {
            //status.backgroundColor = color
            status.backgroundColor = UIColor.gainsboro
        }
    }
    
    func switchStatus(){
        switch input {
        case 0:
            status.backgroundColor = UIColor.gainsboro
        case 1:
            status.backgroundColor = UIColor.systemRed
        case 2:
            status.backgroundColor = UIColor.systemYellow
        case 3:
            status.backgroundColor = UIColor.systemGreen
            //Vibrate
            UIDevice.vibrate()
        default:
            break
        }
    }
    
    //change input
    func tapStatus(){
        input = input + 1
        if input > 3 {
            input = 0
        }
        switchStatus()
        updateStatus()
    }
    
    //update Database
    func updateStatus(){
        
    }
    
}
