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

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "HomeView")
        setupSwipe()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
}

//Add Button XIB and View
//Graphic Interface Development

//Handle Navigation
extension HomeViewController {
    
    func setupSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(calendarAction))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(menuAction))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    func SegueToLanding(){
        let loginView = LoginViewController()
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }
   
    func setupNavigationBar(){
        //Border Color
        navigationController?.navigationBar.standardAppearance.shadowColor = UIColor.darkGray
        //Background Color
        navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.white
        //Tint Color
        navigationController?.navigationBar.tintColor = UIColor.black
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuAction))
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(searchAction))
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterAction))
        let calendarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: self, action: #selector(calendarAction))
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backIcon")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItems = [calendarButton,filterButton,searchButton]
    }
    
    @objc func menuAction() {
        let menuView = MenuViewController(nibName: "MenuView", bundle: nil)
        let menu = SideMenuNavigationController(rootViewController: menuView)
        menu.leftSide = true
        menu.setNavigationBarHidden(true, animated: false)
        present(menu, animated: true, completion: nil)
    }
    
    @objc func searchAction() {}
    @objc func filterAction() {
        SegueToFilter()
    }
    
    func SegueToFilter(){
        let filterView = FilterViewController()
        filterView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(filterView, animated: true)
    }
    
    @objc func calendarAction() {
        SegueToCalendar()
    }
    
    func SegueToCalendar(){
        let calendarView = CalendarViewController()
        calendarView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(calendarView, animated: true)
    }
    
}
