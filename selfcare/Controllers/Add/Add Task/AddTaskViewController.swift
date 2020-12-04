//
//  AddTaskViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddTaskView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
}

extension AddTaskViewController {
    func setupNavigationBar(){
        //Border Color
        //navigationController?.navigationBar.standardAppearance.shadowColor = UIColor.darkGray
        //Background Color
        //navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.white
        //Tint Color
        navigationController?.navigationBar.tintColor = UIColor.lightGray
    
        //navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "exitIcon")
        //navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "exitIcon")
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
