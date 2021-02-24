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
    @IBOutlet weak var side: UIView!
    
    var state = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        //bg.layer.cornerRadius = 10
        //bg.layer.borderWidth = 3
        side.layer.cornerRadius = 4
    }
    
    func updateCell(input: String,color: UIColor){
        title.text = input
        if state == 0 {
            //updateSelected(color: color)
            updateRemaining(color: color)
        } else {
            //updateRemaining(color: color)
            updateSelected(color: color)
        }
    }
    
    func updateSelected(color: UIColor){
        side.backgroundColor = color
        side.layer.borderWidth = 0
        side.alpha = 0.9
        bg.layer.borderWidth = 0
        title.frame = CGRect(x: 22, y: 3, width: 104, height: 40)
        title.textAlignment = .left
        title.alpha = 0.8
    }
    
    func updateRemaining(color: UIColor){
        side.backgroundColor = UIColor.clear
        bg.backgroundColor = UIColor.clear
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 3
        bg.layer.borderColor = color.cgColor
        bg.alpha = 0.9
        title.frame = CGRect(x: 8, y: 4, width: 116, height: 40)
        title.textAlignment = .center
        title.alpha = 1
        
    }
    
    func blank(){
        title.text = ""
        bg.layer.borderColor = UIColor.clear.cgColor
        bg.backgroundColor = UIColor.clear
        side.backgroundColor = UIColor.clear
        side.layer.borderWidth = 0
    }
    
}
