//
//  FullViewMenuMiniCell.swift
//  selfcare
//
//  Created by Michael Brewington on 3/12/21.
//

import Foundation
import UIKit

class FullViewMenuMiniCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
    }
    
    func updateLabel(string: String){
        label.text = string
    }
    
}
