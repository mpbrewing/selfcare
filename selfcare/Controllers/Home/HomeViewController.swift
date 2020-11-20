//
//  HomeViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/15/20.
//

import Foundation
import UIKit
import Firebase
import SideMenu

class HomeViewControler: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "HomeView")
        setupSwipe()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        setupNavigationBar()
    }
    
    func setupSwipe(){
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(menuAction))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(menuAction))
        //leftSwipe.direction = .left
        rightSwipe.direction = .right
        //view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
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
        
        self.view.addSubview(navigationBar)
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: nil, action: #selector(menuAction))
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: nil, action: #selector(searchAction))
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: nil, action: #selector(filterAction))
        let calendarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: nil, action: #selector(calendarAction))
        
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItems = [calendarButton,filterButton,searchButton]
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func menuAction() {
        let menuView = MenuViewController(nibName: "MenuView", bundle: nil)
        let menu = SideMenuNavigationController(rootViewController: menuView)
        menu.leftSide = true
        menu.setNavigationBarHidden(true, animated: false)
        present(menu, animated: true, completion: nil)
    }
    @objc func searchAction() { }
    @objc func filterAction() { }
    @objc func calendarAction() { }
    
}

//Add Calendar XIB and View Controller
//Add Filter XIB and View Controller
//Add Button XIB and View
//Graphic Interface Development
