//
//  FullViewDescription.swift
//  selfcare
//
//  Created by Michael Brewington on 3/18/21.
//

import Foundation
import UIKit

class FullViewDescription: UITableViewCell, UITextViewDelegate  {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var hiddend: UITextView!
    @IBOutlet weak var emoji: UILabel!
    
    var status = Int()
    var height: CGFloat = CGFloat() {
        didSet {
            print("height: \(height)")
            descriptionTextView.frame = CGRect(x: 43, y: 10, width: 356, height: height)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func updateDescription(){
        descriptionTextView.frame = CGRect(x: 43, y: 10, width: 356, height: height)
        manageAnimation()
    }
    
    func manageAnimation() {
        UIView.animate(withDuration: 0.1, delay: 7.0, options: .curveEaseOut, animations: {
            self.descriptionTextView.becomeFirstResponder()
        }, completion: { finished in
        })
    }
    
    func setupXIB() {
        //Change Cell Icon Tint Color to Gainsboro
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.white
        descriptionTextView.delegate = self
        hiddend.isHidden = true
        descriptionTextView.textColor = UIColor.gainsboro
        hiddend.textColor = UIColor.gainsboro
        icon.isHidden = true
        emoji.text = "📖"
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
        if textView.textColor == UIColor.gainsboro {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateIcon()
        if textView.contentSize.height != height {
            height = textView.contentSize.height
            //print("dh AddDescriptionCell: \(height)")

            hiddend.frame = CGRect(x: 43, y: 10, width: 356, height: height)
            hiddend.text = descriptionTextView.text
            hiddend.textColor = descriptionTextView.textColor
            passDescriptionText()
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.gainsboro
        }
        if textView.contentSize.height == height {
            passDescriptionText()
        }
        //
    }
    
    func updateIcon(){
        if descriptionTextView.text!.count > 0 {
            
        } else {
            //icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
           // icon.tintColor = UIColor.lightGray
        }
    }
    
}

//Handle and Pass Description Text
extension FullViewDescription {
    
    func passDescriptionText()
    {
        //Pass Index and Description Text
        let notif = ["index":0,"description":descriptionTextView.text!,"height":height] as [String : Any]
        NotificationCenter.default.post(name: .toFullView, object: nil,userInfo: notif)
    }
    
}
