//
//  FilterViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/24/20.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "FilterView")
        setupNavigationBar()
        modifyAddNavBar()
    }

    
}

extension FilterViewController {
    
    func setupNavigationBar() {
        navigationItem.title = "Filter"
    }
    
}
