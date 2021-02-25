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
    //@IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    //@IBOutlet weak var hiddenTextView: UITextView!
    //Change to TextView when you descide to make expandable
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
        //let newPosition = descriptionTextView.endOfDocument
        //descriptionTextView.selectedTextRange = descriptionTextView.textRange(from: newPosition, to: newPosition)
       // if height != 40.0 {
            //hiddend.isHidden = false
            //descriptionTextView.isHidden = true
        
        manageAnimation()
        //self.contentView.endEditing(true)
       // }
        
    }
    
    func manageAnimation() {
        UIView.animate(withDuration: 0.1, delay: 7.0, options: .curveEaseOut, animations: {
            //self.contentView.endEditing(false)
            self.descriptionTextView.becomeFirstResponder()
            //self.descriptionTextView.isHidden = false
            //self.hiddend.isHidden = true
        }, completion: { finished in
          //print("animation complete!")
        })
    }
    
    func setupXIB() {
        //Change Cell Icon Tint Color to Gainsboro
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        //Update Placeholder Text and Color
        //descriptionTextView.attributedPlaceholder = NSAttributedString(string: "Enter description",
                                     //attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        //descriptionTextView.placeholder
        descriptionTextView.delegate = self
        hiddend.isHidden = true
        //automaticallyAdjustsScrollViewInsets = false
        //descriptionTextView.automaticallyAdjustsScrollIndicatorInsets = false
        //descriptionTextView.adjustsFontForContentSizeCategory = true
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
            //hiddend.becomeFirstResponder()
            //hiddend.isHidden = false
            passDescriptionText()
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /*
        if textView.contentSize.height != height {
            passDescriptionText()
        } */
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    /*
    @IBAction func EditingChanged(_ sender: Any) {
        //updateIcon()
    }
    
    @IBAction func EditingDidEnd(_ sender: Any) {
        passDescriptionText()
        //updateIcon()
    }
    */
    
    func updateIcon(){
        //let colors = [UIColor.gainsboro,UIColor.systemRed,UIColor.systemYellow,UIColor.systemGreen]
        if descriptionTextView.text!.count > 0 {
            //icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            //icon.tintColor = UIColor.silver
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

