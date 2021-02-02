//
//  ExcludedDates.swift
//  selfcare
//
//  Created by Michael Brewington on 1/26/21.
//

import Foundation
import UIKit

class ExcludedDates: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "ExcludedDatesView")
        setupNavigationBar()
        setupStyle()
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Excluded Dates"
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.appleRed.cgColor
        saveButton.layer.cornerRadius = 20
        saveButton.layer.backgroundColor = UIColor.appleRed.cgColor
    }
    
}
