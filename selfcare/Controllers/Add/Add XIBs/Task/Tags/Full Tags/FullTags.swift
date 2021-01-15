//
//  FullTags.swift
//  selfcare
//
//  Created by Michael Brewington on 1/14/21.
//

import Foundation
import UIKit

class FullTags: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "TagsView")
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Tags"
    }
    
}
