//
//  EndsMiniNibCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/1/21.
//

import Foundation
import UIKit

class EndsMiniNibCell: UICollectionViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateStyle(style: Int){
        switch style {
        case 0:
            date.textColor = UIColor.appleRed
        case 1:
            date.textColor = UIColor.systemGray
        case 2:
            date.textColor = UIColor.lightGray
        case 3:
            date.textColor = UIColor.gainsboro
        default:
            break
        }
    }
    
    func isSelected(bool: Bool, style: Int){
        switch bool {
        case true:
            bg.layer.cornerRadius = 10
            bg.layer.backgroundColor = UIColor.appleRed.cgColor
            date.textColor = UIColor.white
        case false:
            bg.layer.backgroundColor = UIColor.clear.cgColor
            updateStyle(style: style)
        }
    }
    
    func isBetween(){
        bg.layer.cornerRadius = 10
        bg.layer.backgroundColor = UIColor.lightGains.cgColor
        date.textColor = UIColor.appleRed
    }
    
}
