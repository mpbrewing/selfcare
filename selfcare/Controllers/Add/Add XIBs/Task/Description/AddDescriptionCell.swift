//
//  AddDescriptionCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddDescriptionCell: UITableViewCell,UITextViewDelegate {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var hiddend: UITextView!

    var status = Int()
    var height: CGFloat = 40
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Update NIB on init
        setupXIB()
    }
    
    func updateDescription(){
        descriptionTextView.frame = CGRect(x: 43, y: 9, width: 356, height: height)
        manageAnimation()
    }
    
    func manageAnimation() {
        UIView.animate(withDuration: 0.1, delay: 7.0, options: .curveEaseOut, animations: {
            self.descriptionTextView.becomeFirstResponder()
        }, completion: { finished in
          //print("animation complete!")
        })
    }
    
    func setupXIB() {
        //Change Cell Icon Tint Color to Gainsboro
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        descriptionTextView.delegate = self
        hiddend.isHidden = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if text == "\n" {
            //return false
            descriptionTextView.resignFirstResponder()
        }
        return numberOfChars < 140    // 10 Limit Value
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateIcon()
        if textView.contentSize.height != height {
            height = textView.contentSize.height
            print("dh AddDescriptionCell: \(height)")

            hiddend.frame = CGRect(x: 43, y: 9, width: 356, height: height)
            hiddend.text = descriptionTextView.text
            hiddend.textColor = descriptionTextView.textColor
            passDescriptionText()
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func updateIcon(){
        if descriptionTextView.text!.count > 0 {
        } else {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = UIColor.gainsboro
        }

        
    }
    
}

//Handle and Pass Description Text
extension AddDescriptionCell {
    
    func passDescriptionText()
    {
        //Pass Index and Description Text
        let notif = ["index":1,"description":descriptionTextView.text!,"height":height] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
}

