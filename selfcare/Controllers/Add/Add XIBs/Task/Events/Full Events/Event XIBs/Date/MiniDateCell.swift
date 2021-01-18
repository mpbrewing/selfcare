//
//  MiniDateCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit

class MiniDateCell: UICollectionViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateStyle(style: Int){
        switch style {
        case 0:
            date.textColor = UIColor.appleBlue
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
            //contentView.layer.cornerRadius = 10
            //contentView.layer.backgroundColor = UIColor.appleBlue.cgColor
            bg.layer.cornerRadius = 10
            bg.layer.backgroundColor = UIColor.appleBlue.cgColor
            date.textColor = UIColor.white
        case false:
            //contentView.layer.backgroundColor = UIColor.clear.cgColor
            bg.layer.backgroundColor = UIColor.clear.cgColor
            updateStyle(style: style)
        }
    }
    
    func isBetween(){
        //contentView.layer.cornerRadius = 10
        //contentView.layer.backgroundColor = UIColor.lightGains.cgColor
        bg.layer.cornerRadius = 10
        bg.layer.backgroundColor = UIColor.lightGains.cgColor
        date.textColor = UIColor.appleBlue
    }
    
}
