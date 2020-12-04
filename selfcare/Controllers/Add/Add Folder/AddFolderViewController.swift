//
//  AddFolderViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit

class AddFolderViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddFolderView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
}

extension AddFolderViewController {
    func setupNavigationBar(){
        //Border Color
        //navigationController?.navigationBar.standardAppearance.shadowColor = UIColor.darkGray
        //Background Color
        //navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.white
        //Tint Color
        navigationController?.navigationBar.tintColor = UIColor.lightGray
    
        //navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backIcon")
        //navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backIcon")
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
