//
//  FilePathCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/11/21.
//

import Foundation
import UIKit

class FilePathCell: UITableViewCell {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var down: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        //Border Surrounding Title
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 3
        bg.layer.borderColor = UIColor.gainsboro.cgColor
        //Change Color of Down Image
        down.contentMode = .scaleAspectFill
        down.image = down.image?.withRenderingMode(.alwaysTemplate)
        down.tintColor = UIColor.lightGray
    }
    
    func updateCell(input: String,files:Bool){
        title.text = input
        if files == true {
            down.isHidden = false
        } else {
            down.isHidden = true
        }
    }
    
    func updateSelected(select: Bool){
        if select == true {
            bg.layer.borderColor = UIColor.appleGreen.cgColor
            title.textColor = UIColor.appleGreen
            down.contentMode = .scaleAspectFill
            down.image = down.image?.withRenderingMode(.alwaysTemplate)
            down.tintColor = UIColor.appleGreen
        } else {
            bg.layer.borderColor = UIColor.gainsboro.cgColor
            title.textColor = UIColor.gray
            down.contentMode = .scaleAspectFill
            down.image = down.image?.withRenderingMode(.alwaysTemplate)
            down.tintColor = UIColor.lightGray
        }
    }
    
}
