//
//  AddButtonCellClass.swift
//  selfcare
//
//  Created by Michael Brewington on 11/30/20.
//

import Foundation
import UIKit

class AddButtonCellClass: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var rowImage: UIImageView!
    @IBOutlet weak var rowView: UIView!
    
    func setData(image: UIImage,text: String)
    {
        rowImage.image = image
        rowImage.image = rowImage.image?.withRenderingMode(.alwaysTemplate)
        rowImage.tintColor = UIColor.black
        rowLabel.text = text
        rowView.layer.borderWidth = 2.0
        rowView.backgroundColor = UIColor.white
        rowView.layer.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        rowView.layer.cornerRadius = rowView.frame.width/2
    }
    
    
}
