//
//  CalendarViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/24/20.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "CalendarView")
        setupSwipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
     
    
}

//Handle Navigation
extension CalendarViewController {
    
    func setupSwipe(){
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(homeAction))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func homeAction() {
        SegueToHome()
    }
    
    func SegueToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    
     func setupNavigationBar(){
         //Border Color
         navigationController?.navigationBar.standardAppearance.shadowColor = UIColor.clear
         //Background Color
         //navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.white
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
         //Tint Color
         navigationController?.navigationBar.tintColor = UIColor.black
         let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(searchAction))
         let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterAction))
         let calendarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: self, action: #selector(calendarAction))
         //navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backIcon")
         //navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backIcon")
         //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.rightBarButtonItems = [calendarButton,filterButton,searchButton]
     }
     @objc func searchAction() {}
     @objc func filterAction() {}
     @objc func calendarAction() {}
    
}
