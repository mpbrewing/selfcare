//
//  MenuRowTableViewCell.swift
//  selfcare
//
//  Created by Michael Brewington on 11/19/20.
//

import Foundation
import UIKit

class MenuRowTableViewCell: UITableViewCell{
    
    @IBOutlet weak var rowImage: UIImageView!
    @IBOutlet weak var rowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(image: UIImage,text: String)
    {
        rowImage.image = image
        rowImage.image = rowImage.image?.withRenderingMode(.alwaysTemplate)
        rowImage.tintColor = UIColor.white
        rowLabel.text = text
    }
    
}
