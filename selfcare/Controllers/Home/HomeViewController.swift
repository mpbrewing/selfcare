//
//  HomeViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/15/20.
//

import Foundation
import UIKit
import Firebase

class HomeViewControler: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        modifyButton()
    }
    
    override func loadView() {
        Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
    }
    
    func modifyButton(){
        logout.layer.cornerRadius = 20
    }
    
    @IBOutlet weak var logout: UIButton!
    
    @IBAction func logoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        SegueToLanding()
    }
    
    func SegueToLanding(){
        let loginView = LoginViewController()
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }
    
    
}

//Add Navigation Bar
//Add Side Menu
//Add Calendar XIB and View Controller
//Add Filter XIB and View Controller
//Add Button XIB and View
//Graphic Interface Development
