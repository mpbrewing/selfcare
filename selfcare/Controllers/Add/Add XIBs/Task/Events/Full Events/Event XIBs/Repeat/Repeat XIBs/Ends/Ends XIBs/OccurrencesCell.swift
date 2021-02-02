//
//  OccurrencesCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/26/21.
//

import Foundation
import UIKit

class OccurrencesCell: UIView, UITextFieldDelegate{
    
    @IBOutlet var viewHandle: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var input = 0
    var inputString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        viewHandle = loadViewFromNib(name: "OccurrencesView")
        // use bounds not frame or it'll be offset
        viewHandle!.frame = bounds
        // Make the view stretch with containing view
        viewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(viewHandle!)
        handleInit()
    }
    
    func handleInit(){
        setupTextField()
    }
    
    func setupTextField(){
        textField.delegate = self
        if textField.isFirstResponder == false {
            textField.becomeFirstResponder()
        }
        label.text = "After \(input) occurrences"
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
      
        if string == "" && textField.text?.count == 1 && textField.text! != "0"{
            textField.text = "00"
        }
        
        if string != "" && textField.text == "0" {
            textField.text = ""
        } else if string == "" && textField.text == "0" {
            return false
        }
        
        if textField.text!.count > 6 && string != "" {
            return false
        }
        
        return true
    }
    
    @IBAction func changed(_ sender: Any) {
        label.text = "After \(textField.text!) occurrences"
    }
    
    func updateLabel(){
        label.text = "After \(textField.text!) occurrences"
    }
    
}
