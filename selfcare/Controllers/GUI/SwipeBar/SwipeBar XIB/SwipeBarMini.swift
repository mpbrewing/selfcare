//
//  SwipeBarMini.swift
//  selfcare
//
//  Created by Michael Brewington on 3/3/21.
//

import Foundation
import UIKit

class SwipeBarMini: UICollectionViewCell {
    
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        bg.layer.cornerRadius = 6
    }
    
    func isSelected(bool: Bool,count: Int){
        if bool == true {
            bg.layer.backgroundColor = UIColor.black.cgColor
            let width = (315 / count) - 4
            let height = contentView.frame.height - 24
            bg.frame = CGRect(x: 2, y: 22, width: Int(width), height: Int(height))
            bg.layer.cornerRadius = 6
        } else {
            bg.layer.backgroundColor = UIColor.gainsboro.cgColor
            let width = (315 / count) - 4
            let height = contentView.frame.height - 64
            bg.frame = CGRect(x: 2, y: 62, width: Int(width), height: Int(height))
            bg.layer.cornerRadius = 6
        }
    }
    
}
