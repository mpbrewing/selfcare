//
//  ViewFullFilePath.swift
//  selfcare
//
//  Created by Michael Brewington on 3/9/21.
//

import Foundation
import UIKit

class ViewFullFilePath: UITableViewCell {
    
    @IBOutlet weak var filePath: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateFilePath(string: NSMutableAttributedString){
        filePath.attributedText = string
    }
    
}
