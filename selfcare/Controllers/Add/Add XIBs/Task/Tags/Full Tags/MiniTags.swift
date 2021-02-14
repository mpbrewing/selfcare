//
//  MiniTags.swift
//  selfcare
//
//  Created by Michael Brewington on 2/13/21.
//

import Foundation
import UIKit

class MiniTags: UICollectionViewCell {
    
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var color: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        
    }
    
    func setupStyle(){
        checkmark.isHidden = true
        color.layer.cornerRadius = 10
        checkmark.contentMode = .scaleAspectFill
        checkmark.image = checkmark.image?.withRenderingMode(.alwaysTemplate)
        checkmark.tintColor = UIColor.white
    }
    
    func setupColor(input: UIColor,check:Bool,index: Int){
        color.backgroundColor = input
        checkIndex(index: index)
        if check == true {
            checkmark.isHidden = false
        } else {
            checkmark.isHidden = true
        }
    }
    
    func checkIndex(index: Int){
        if index == 0 {
            checkmark.image = #imageLiteral(resourceName: "cancel_tags")
            updateCheckmark()
        } else {
            checkmark.image = #imageLiteral(resourceName: "checkmark")
            updateCheckmark()
        }
    }
    
    func updateCheckmark(){
        checkmark.contentMode = .scaleAspectFill
        checkmark.image = checkmark.image?.withRenderingMode(.alwaysTemplate)
        checkmark.tintColor = UIColor.white
    }
    
}
