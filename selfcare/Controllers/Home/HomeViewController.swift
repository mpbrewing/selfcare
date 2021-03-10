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
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //toggleAlpha(state: false)
        loadXIB(name: "HomeView")
        downloadData()
        setupSwipe()
        setupSwipeView()
        setupSwipeBarClass()
        setupAddButton()
        setupAddButtonBackground()
        NotificationCenter.default.addObserver(self, selector: #selector(setAddButton(notification:)), name: .addButton, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setAddItemSegue(notification:)), name: .addItemSegue, object: nil)
        //test.layer.cornerRadius = 10
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "backIcon"), transitionMaskImage: #imageLiteral(resourceName: "backIcon"))
        //
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        //Reload SwipeClass if new
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
    }
    
    var AddButtonView = AddButtonViewClass()
    var swipeClassView = SwipeClass()
    var addButtonBackground = UIView()
    var swipeBarClass = SwipeBarClass()
    
    //@IBOutlet weak var test: SwipeBarClass!
    
    var tags = [Tag]()
    
}

//Handle Navigation
extension HomeViewController {
    
    func downloadData(){
        downloadTags(db: db, completion: { data in
            self.tags = data
            print("HomeViewController: Tags: \(self.tags.count)")
        })
    }
    
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
    
    func switchNavBG(state: Bool) {
        switch state {
        //case true:
        case false:
            navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.white
        //case false:
        case true:
            navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
            navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
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
        if AddButtonView.state == true {
            AddButtonView.addButtonDown()
        }
    }
    
    func SegueToCalendar(){
        let calendarView = CalendarViewController()
        calendarView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(calendarView, animated: true)
    }
    
}
extension HomeViewController {
    
    func setupSwipeView() {
        //swipeClassView = SwipeClass(frame: CGRect(x: 0, y: 92, width: 414, height: 660))
        swipeClassView.frame = CGRect(x: 0, y: 92, width: 414, height: 660)
        self.view.addSubview(swipeClassView)
    }
    
    func setupSwipeBarClass() {
        swipeBarClass.frame = CGRect(x: 10, y: 770, width: 315, height: 100)
        self.view.addSubview(swipeBarClass)
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
        AddButtonView.frame = CGRect(x: (Int(screenWidth)-width), y: (Int(screenHeight)-height), width: width, height: height)
        //AddButtonView = AddButtonViewClass(frame: CGRect(x: (Int(screenWidth)-width), y: (Int(screenHeight)-height), width: width, height: height))
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
            toggleAddButtonBackground(state: state)
        case false:
            let width = 72
            let height = 70
            AddButtonView.frame = CGRect(x: (Int(screenWidth)-width), y: (Int(screenHeight)-height), width: width, height: height)
            toggleAddButtonBackground(state: state)
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
        addTaskView.allTags = tags
        addTaskView.items = swipeClassView.items
        addTaskView.wallet = swipeClassView.itemWallet
        addTaskView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(addTaskView, animated: true)
    }
    
    func toggleAddButtonBackground(state: Bool){
        switch state {
        case true:
            addButtonBackground.alpha = 1
            self.view.bringSubviewToFront(addButtonBackground)
            self.view.bringSubviewToFront(AddButtonView)
            switchNavBG(state: state)
        case false:
            addButtonBackground.alpha = 0
            self.view.sendSubviewToBack(addButtonBackground)
            switchNavBG(state: state)
        }
    }
    
    func setupAddButtonBackground(){
        let screenSize = UIScreen.main.bounds
        addButtonBackground.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        //addButtonBackground = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        addButtonBackground.backgroundColor = UIColor.clear
        addButtonBackground.alpha = 0
        self.view.addSubview(addButtonBackground)
        let gradient = CAGradientLayer()
        gradient.frame = addButtonBackground.bounds
        gradient.colors = [UIColor.clear.cgColor,UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1.0)
        gradient.cornerRadius = 20
        addButtonBackground.layer.addSublayer(gradient)
        self.view.sendSubviewToBack(addButtonBackground)
        //addButtonBackground.alpha = 0
    }
    
    func toggleAlpha(state: Bool){
        switch state {
        case true:
            swipeBarClass.alpha = 1
            //test.alpha = 1
            swipeClassView.alpha = 1
            AddButtonView.alpha = 1
            //addButtonBackground.alpha = 1
        case false:
            swipeBarClass.alpha = 0
            //test.alpha = 0
            swipeClassView.alpha = 0
            AddButtonView.alpha = 0
            addButtonBackground.alpha = 0
        }
    }
    
}

/*
extension Notification.Name {
     static let addButton = Notification.Name("addButton")
     static let addItemSegue = Notification.Name("addItemSegue")
}
*/
