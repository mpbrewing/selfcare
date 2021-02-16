//
//  TagsPageNumberCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/16/21.
//

import Foundation
import UIKit

class TagsPageNumberCell: UICollectionViewCell {
    
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bg.layer.cornerRadius = 4
        bg.layer.backgroundColor = UIColor.gainsboro.cgColor
    }
    
    func setupStyle(selected: Bool,width: CGFloat){
        setupBg(width: width)
        if selected == true {
            bg.layer.backgroundColor = UIColor.systemGray.cgColor
        } else {
            bg.layer.backgroundColor = UIColor.gainsboro.cgColor
        }
    }
    
    func setupBg(width:CGFloat){
        let holdWidth = width * (9/10)
        let holdX = (width * (1/10))/2
        bg.frame = CGRect(x: holdX, y: 10, width: holdWidth, height: 10)
        bg.layer.cornerRadius = 4
    }
    
    
}
