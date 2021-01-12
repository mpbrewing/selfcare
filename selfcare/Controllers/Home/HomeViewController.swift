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
        //setupSwipeView()
        //setupAddButton()
        NotificationCenter.default.addObserver(self, selector: #selector(setAddButton(notification:)), name: .addButton, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setAddItemSegue(notification:)), name: .addItemSegue, object: nil)
        test.layer.cornerRadius = 10
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupSwipeView()
        setupAddButton()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        //print(navigationController?.navigationBar.isHidden ?? "isHidden: default")
    }
    
    var AddButtonView = UIView()
    var swipeClassView = UIView()
    
    @IBOutlet weak var test: SwipeBarClass!
    
}

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
        navigationController?.navigationBar.standardAppearance.shadowColor = UIColor.clear
        //Background Color
        navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.white
        //Tint Color
        navigationController?.navigationBar.tintColor = UIColor.black
        //
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuAction))
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(searchAction))
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterAction))
        let calendarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: self, action: #selector(calendarAction))
        //
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //
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
extension HomeViewController {
    func setupSwipeView() {
        swipeClassView = SwipeClass(frame: CGRect(x: 0, y: 92, width: 414, height: 660))
        self.view.addSubview(swipeClassView)
    }
}

//Add Button
extension HomeViewController {
    
    func setupAddButton()
    {
        let screenSize = UIScreen.main.bounds
        let heightOffset = CGFloat(10)
        let widthOffset = CGFloat(10)
        let screenWidth = screenSize.width - widthOffset
        let screenHeight = screenSize.height - heightOffset
        let width = 72
        let height = 70
        AddButtonView = AddButtonViewClass(frame: CGRect(x: (Int(screenWidth)-width), y: (Int(screenHeight)-height), width: width, height: height))
        setButtonFrame(state: false)
        self.view.addSubview(AddButtonView)
    }
    
    func setButtonFrame(state: Bool)
    {
        let screenSize = UIScreen.main.bounds
        let heightOffset = CGFloat(10)
        let widthOffset = CGFloat(10)
        let screenWidth = screenSize.width - widthOffset
        let screenHeight = screenSize.height - heightOffset
        
        switch state {
        case true:
            let width = 160
            let height = 420
            AddButtonView.frame = CGRect(x: (Int(screenWidth)-width), y: (Int(screenHeight)-height), width: width, height: height)
        case false:
            let width = 72
            let height = 70
            AddButtonView.frame = CGRect(x: (Int(screenWidth)-width), y: (Int(screenHeight)-height), width: width, height: height)
        }
    }
    
    @objc func setAddButton(notification: NSNotification) {
        if let state = notification.userInfo?["state"] as? Bool {
            setButtonFrame(state: state)
        }
    }
    
    @objc func setAddItemSegue(notification: NSNotification) {
        if let switchSegue = notification.userInfo?["switchSegue"] as? Int {
            navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "exitIcon"), transitionMaskImage: #imageLiteral(resourceName: "exitIcon"))
            switch switchSegue {
            case 0:
                SegueToAddFolder()
            case 1:
                SegueToAddTask()
            default:
                print("HomeViewController: setAddItemSegue: default")
            }
        }
    }
    
    
    func SegueToAddFolder(){
        let addFolderView = AddFolderViewController()
        addFolderView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(addFolderView, animated: true)
    }
    
    func SegueToAddTask(){
        let addTaskView = AddTaskViewController()
        addTaskView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(addTaskView, animated: true)
    }
    
}
/*
extension Notification.Name {
     static let addButton = Notification.Name("addButton")
     static let addItemSegue = Notification.Name("addItemSegue")
}
*/
