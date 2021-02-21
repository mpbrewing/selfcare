//
//  AddEventsCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddEventsCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var eventsLabel: UILabel!
    //@IBOutlet weak var bg: UIView!
    @IBOutlet weak var bgLabel: UILabel!
    @IBOutlet weak var bgButton: UIButton!
    @IBAction func bgButtonAction(_ sender: Any) {
        SegueToEvents()
    }
    
    var events: [Event] = [Event]() {
        didSet {
            //print("events: \(events.count)")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        //
        bgLabel.text = "+"
        bgLabel.textColor = UIColor.gainsboro
        bgButton.layer.cornerRadius = 10
        bgButton.layer.borderColor = UIColor.gainsboro.cgColor
        bgButton.layer.borderWidth = 3
    }
    
    func updateLabel(events:[Event]){
        if events.count > 0 {
            if events.count == 1 {
                eventsLabel.text = "\(events.count) Event"
            } else {
                eventsLabel.text = "\(events.count) Events"
            }
            eventsLabel.textColor = UIColor.black
        } else {
            eventsLabel.text = "Events"
            eventsLabel.textColor = UIColor.lightGray
        }
    }
    
    func SegueToEvents(){
        modifyBackButton()
        let events = FullEvents()
        events.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(events, animated: true)
    }
    
    func modifyBackButton(){
        let vc = findViewController()
        vc?.navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "back2"), transitionMaskImage: #imageLiteral(resourceName: "back2"))
    }
    
}
