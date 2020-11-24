//
//  MenuViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/19/20.
//

import Foundation
import UIKit
import Firebase

class MenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "MenuView")
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //view.backgroundColor = UIColor.blackRussian
    }
    
    // Cell Reuse Identifiers
    let cellHeaderIdentifier = "menuHeader"
    let cellRowIdentifier = "menuRow"
    
    var manageAccountModel = [["Logout": #imageLiteral(resourceName: "settings")]]
    
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
    
    @IBOutlet weak var tableView: UITableView!
    
    func SegueToLanding(){
        let loginView = LoginViewController()
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }
    
    
}

extension MenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return manageAccountModel.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeaderIdentifier,for: indexPath) as UITableViewCell?
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRowIdentifier, for: indexPath) as! MenuRowTableViewCell
            let image = manageAccountModel[indexPath.row].values.first
            let text = manageAccountModel[indexPath.row].keys.first
            cell.setData(image: image!, text: text!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeaderIdentifier) as UITableViewCell?
            return cell!
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0: //Logout
                try! Auth.auth().signOut()
                SegueToLanding()
            default:
                print("")
            }
        default:
            print("MenuViewController: didSelectRowAt: default")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 88
        default:
            return 50
        }
    }
    
    
    
}
