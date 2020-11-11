//
//  OnboardingViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/2/20.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadView()
        
    }
    
    override func loadView() {
        Bundle.main.loadNibNamed("OnboardingView", owner: self, options: nil)
    }


}

