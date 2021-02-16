//
//  SelectMiniCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/15/21.
//

import Foundation
import UIKit

class SelectMiniCell: UICollectionViewCell {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var title: UILabel!
    
    var state = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 3
    }
    
    func updateCell(input: String,color: UIColor){
        title.text = input
        bg.layer.borderColor = color.cgColor
        if state == 0 {
            title.textColor = UIColor.white
            bg.backgroundColor = color
        } else {
            title.textColor = UIColor.black
            bg.backgroundColor = UIColor.clear
        }
    }
    
    func blank(){
        title.text = ""
        bg.layer.borderColor = UIColor.clear.cgColor
        bg.backgroundColor = UIColor.clear
    }
    
}
