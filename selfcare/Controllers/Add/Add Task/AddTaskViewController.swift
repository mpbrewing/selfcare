//
//  AddTaskViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddTaskView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modifyAddNavBar()
        setupNavigationBar()
    }
    
}

extension AddTaskViewController {
    func setupNavigationBar() {
        navigationItem.title = "Task"
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        btn1.titleLabel?.font =  UIFont(name: "Nexa-Normal", size: 10)
        let attributedTitle = NSAttributedString(string: "Save", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Nexa-Bold", size: 14)!])
        btn1.setAttributedTitle(attributedTitle, for: .normal)
        btn1.layer.cornerRadius = 8
        btn1.backgroundColor = UIColor.systemGreen
        btn1.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        let saveButton = UIBarButtonItem(customView: btn1)
        navigationItem.rightBarButtonItem = saveButton
    }
    
     @objc func saveButtonAction() {
         print("AddTaskViewController: SaveButtonAction")
     }
     
}

//Pass data back to Home View Controller
//Add Swipe Gesture Recognizer
//Create Xibs and Classes
//Save File To Database
//Understand File Flow and Data management ...
//Home View UI Structures
//
