//
//  ViewTagsCell.swift
//  selfcare
//
//  Created by Michael Brewington on 3/1/21.
//

import Foundation
import UIKit

class ViewTagsCell: UITableViewCell {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var modify: UIButton!
    @IBOutlet weak var modifyIcon: UIImageView!
    @IBAction func modifyAction(_ sender: Any) {
        //pass to full tags
        //segue to full tags
        SegueToFullTags()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        //Border Surrounding Title
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 3
        bg.layer.borderColor = UIColor.gainsboro.cgColor
        //Change Color of Checkmark Image
        setupCheckmark(color: UIColor.gainsboro)
        setupButton()
    }
    
    func setupCheckmark(color: UIColor){
        checkmark.contentMode = .scaleAspectFill
        checkmark.image = checkmark.image?.withRenderingMode(.alwaysTemplate)
        checkmark.tintColor = color
    }
    
    func setupButton(){
        modifyIcon.contentMode = .scaleAspectFill
        modifyIcon.image = modifyIcon.image?.withRenderingMode(.alwaysTemplate)
        modifyIcon.tintColor = UIColor.gainsboro
    }
    
    func updateSelected(input: String, color: UIColor, state: Bool){
        title.text = input
        if state == true {
            //title.textColor = color
            bg.layer.borderColor = color.cgColor
            setupCheckmark(color: color)
            checkmark.isHidden = false
        } else {
            //title.textColor = UIColor.black
            bg.layer.borderColor = UIColor.gainsboro.cgColor
            setupCheckmark(color: UIColor.gainsboro)
            checkmark.isHidden = true
        }
    }
    
    func SegueToFullTags(){
        //modifyBackButton()
        //prepare view
        let tags = FullTags()
        tags.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(tags, animated: true)
    }
    
}
