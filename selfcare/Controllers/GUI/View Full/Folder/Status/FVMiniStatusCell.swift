//
//  FVMiniStatusCell.swift
//  selfcare
//
//  Created by Michael Brewington on 3/9/21.
//

import Foundation
import UIKit

class FVMiniStatusCell: UICollectionViewCell {
    
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func returnColor(status: Int)->UIColor{
        switch status {
        case 0:
            return UIColor.gainsboro
        case 1:
            return UIColor.systemRed
        case 2:
            return UIColor.systemYellow
        case 3:
            return UIColor.systemGreen
        default:
            return UIColor.gainsboro
        }
    }
     
    func setupStyle(){
        bg.layer.cornerRadius = 6
    }
    
    func updateColor(status:Int){
        bg.backgroundColor = returnColor(status: status)
        if status == 0 {
            bg.alpha = 0.4
        } else {
            bg.alpha = 1
        }
    }
    
    func updateFrame(width: CGFloat){
        //let height = contentView.frame.height - 4
        let holdWidth = width - 2
        bg.frame = CGRect(x: 1, y: 1, width: Int(holdWidth), height: Int(18))
        bg.layer.cornerRadius = 6
    }
    
}
