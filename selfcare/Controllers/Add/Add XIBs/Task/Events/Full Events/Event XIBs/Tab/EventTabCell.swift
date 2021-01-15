//
//  EventTabCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit
class EventTabCell: UICollectionViewCell {
    
    @IBOutlet weak var tab: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateStyle(row: Int,state:Int){
        let colorArray = [UIColor.appleBlue,UIColor.applePurple,UIColor.appleRed,UIColor.appleOrange,UIColor.appleYellow]
        tab.contentMode = .scaleAspectFill
        tab.image = tab.image?.withRenderingMode(.alwaysTemplate)
        if row == state {
            tab.tintColor = colorArray[row]
        } else {
            tab.tintColor = UIColor.gainsboro
        }
    }
    
    
}
