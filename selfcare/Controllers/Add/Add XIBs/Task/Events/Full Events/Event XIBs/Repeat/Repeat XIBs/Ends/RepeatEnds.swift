//
//  RepeatEnds.swift
//  selfcare
//
//  Created by Michael Brewington on 1/26/21.
//

import Foundation
import UIKit

class RepeatEnds: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var state = 0
    var occurrencesView = OccurrencesCell()
    var dateView = OnADateCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "RepeatEndsView")
        switchState()
        setupStyle()
        hideKeyboardWhenTappedAround()
    }
    
    func setupNavigationBar(title: String){
        navigationItem.title = "\(title)"
    }
    
    func switchState(){
        if state == 1 {
            setupNavigationBar(title: "Ends on a date")
            dateView = OnADateCell(frame: CGRect(x: 0, y: 92, width: 414, height: 634))
            view.addSubview(dateView)
        } else {
            //setupNavigationBar(title: "Ends after #")
            occurrencesView = OccurrencesCell(frame: CGRect(x: 0, y: 92, width: 414, height: 414))
            view.addSubview(occurrencesView)
        }
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.appleRed.cgColor
        saveButton.layer.cornerRadius = 20
        saveButton.layer.backgroundColor = UIColor.appleRed.cgColor
    }
    
}
