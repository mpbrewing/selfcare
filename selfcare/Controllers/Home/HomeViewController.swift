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
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        setupNavigationBar()
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
    
    
    func setupNavigationBar(){
        let width = view.frame.width
        let height = view.safeAreaInsets.top
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: width, height: height))
        //Border Color
        navigationBar.standardAppearance.shadowColor = UIColor.darkGray
        //Background Color
        navigationBar.standardAppearance.backgroundColor = UIColor.white
        //Tint Color
        navigationBar.tintColor = UIColor.black
        //
        
        self.view.addSubview(navigationBar)
        //let navigationItem = UINavigationItem(title: "Navigation bar")
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: nil, action: #selector(menuAction))
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: nil, action: #selector(searchAction))
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: nil, action: #selector(filterAction))
        let calendarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: nil, action: #selector(calendarAction))
        
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItems = [calendarButton,filterButton,searchButton]
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func menuAction() { }
    @objc func searchAction() { }
    @objc func filterAction() { }
    @objc func calendarAction() { }
    
}

//Add Navigation Bar *tn
//Add Side Menu 
//Add Calendar XIB and View Controller
//Add Filter XIB and View Controller
//Add Button XIB and View
//Graphic Interface Development
