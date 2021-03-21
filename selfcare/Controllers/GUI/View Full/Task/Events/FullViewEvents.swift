//
//  FullViewEvents.swift
//  selfcare
//
//  Created by Michael Brewington on 3/18/21.
//

import Foundation
import UIKit

class FullViewEvents: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    var events: [Event] = [Event]() {
        didSet {
            //print("events: \(events.count)")
            //eventCollection.reloadData()
            setupXIB()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.white
        if events.count > 0 {
            eventsLabel.textColor = UIColor.white
        } else {
            eventsLabel.textColor = UIColor.gainsboro
        }
        emoji.text = "🗓"
        icon.isHidden = true
    }
    
}
