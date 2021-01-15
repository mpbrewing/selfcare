//
//  FullFilePath.swift
//  selfcare
//
//  Created by Michael Brewington on 1/14/21.
//

import Foundation
import UIKit

class FullFilePath: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "FilePathView")
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "File Path"
    }
    
}
