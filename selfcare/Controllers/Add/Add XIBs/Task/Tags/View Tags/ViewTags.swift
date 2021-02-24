//
//  ViewTags.swift
//  selfcare
//
//  Created by Michael Brewington on 2/24/21.
//

import Foundation
import UIKit

class ViewTags: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "ViewTagsView")
        setupNavigationBar()
        //setupStyle()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Tags"
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.systemTeal.cgColor
    }
    
}
