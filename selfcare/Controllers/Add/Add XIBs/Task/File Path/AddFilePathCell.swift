//
//  AddFilePathCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddFilePathCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var filePathLabel: UILabel!
    @IBOutlet weak var filePath: UILabel!
    
    var status = Int()
    
    var selectedFilePath: [Item] = [Item]() {
        didSet {
            //print("filePath: \(selectedFilePath.count)")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
    }
    
    func updateLabel(items:[Item]){
        var string = String()
        //➡️
        selectedFilePath = items
        updateIcon()
        if items.count > 0 {
            for i in 0...items.count-1{
                let details = items[i].details
                let title = details["title"] as! String
                string.append(title)
                if i != items.count-1 {
                    string.append(" ➡️ ")
                }
            }
            //filePath.text = string
            //filePath.textColor = UIColor.black
            filePathLabel.text = string
            filePathLabel.textColor = UIColor.black
        } else {
            //filePath.text = ""
            filePathLabel.text = "File path"
            filePathLabel.textColor = UIColor.lightGray
        }
    }
    
    func updateIcon(){
        //let colors = [UIColor.gainsboro,UIColor.systemRed,UIColor.systemYellow,UIColor.systemGreen]
        if selectedFilePath.count > 0 {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            //icon.tintColor = UIColor.silver
            //icon.tintColor = UIColor.systemGreen
            //icon.tintColor = colors[status]
        } else {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = UIColor.gainsboro
        }
    }
    
    
}
