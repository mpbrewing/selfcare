//
//  AddTaskViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddTaskView")
        setupTableView()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modifyAddNavBar()
        setupNavigationBar()
    }
    
    let cellTitleIdentifier = "addTitle"
    let cellMenuIdentifier = "addMenu"
    
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
        navigationController?.popViewController(animated: true)
     }
     
}

extension AddTaskViewController {

     func setupTableView()
     {
         // Title
         tableView.register(UINib(nibName: "AddTitleView", bundle: nil), forCellReuseIdentifier: cellTitleIdentifier)
         // Menu
         tableView.register(UINib(nibName: "AddMenuView", bundle: nil), forCellReuseIdentifier: cellMenuIdentifier)
         //
         tableView.delegate = self
         tableView.dataSource = self
         //
         tableView.tableFooterView = UIView()
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleIdentifier, for: indexPath) as! AddTitleCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellMenuIdentifier, for: indexPath) as! AddMenuCell
            cell.addState = 1
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleIdentifier, for: indexPath) as! AddTitleCell
            return cell
        }
    }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         switch indexPath.row {
         case 0:
             return 60
         case 1:
             return 743
         default:
             return 50
         }
     }
    
    
}

//Pass data back to Home View Controller
//Add Swipe Gesture Recognizer
//Create Xibs and Classes
//Save File To Database
//Understand File Flow and Data management ...
//Home View UI Structures
//
