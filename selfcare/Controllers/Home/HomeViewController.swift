//
//  HomeViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/15/20.
//

import Foundation
import UIKit

class HomeViewControler: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }
    
    override func loadView() {
        Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)
    }
    
}

//Authenticate Users
//Add Navigation Bar
//Add Side Menu
//Add Calendar XIB and View Controller
//Add Filter XIB and View Controller
//Add Button XIB and View
//Graphic Interface Development
