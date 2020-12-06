//
//  AddFolderViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit
//UITableViewDelegate, UITableViewDataSource
class AddFolderViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddFolderView")
        //setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modifyAddNavBar()
        setupNavigationBar()
    }
    
}

extension AddFolderViewController {
    func setupNavigationBar() {
        navigationItem.title = "Folder"
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
         print("AddFolderViewController: SaveButtonAction")
     }
}

extension AddFolderViewController {
    /*
     func setupTableView()
     {
         // Register the Header cell
         tableView.register(UINib(nibName: "MenuHeaderCell", bundle: nil), forCellReuseIdentifier: cellHeaderIdentifier)
         // Register the Row cell
         tableView.register(UINib(nibName: "MenuRowCell", bundle: nil), forCellReuseIdentifier: cellRowIdentifier)
         // This view controller itself will provide the delegate methods and row data for the table view.
         tableView.delegate = self
         tableView.dataSource = self
         //
         tableView.tableFooterView = UIView()
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    */
}
