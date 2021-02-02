//
//  LocationCellClass.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class LocationCellClass: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateLabel(name:String,input:String){
        label.text = name
        location.text = input
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.darkGray
    }
    
}
