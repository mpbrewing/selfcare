//
//  LoginViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/10/20.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadView()
        setupButtonStyle()
    }
    
    override func loadView() {
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
    }
    
    func setupButtonStyle() {
        SignUpButton.layer.cornerRadius = 15
        SignInButton.layer.cornerRadius = 15
        SignInButton.layer.borderWidth = 2
        SignInButton.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func SignUpButtonDown(_ sender: Any) {
        
    }
    
    @IBAction func SignInButtonDown(_ sender: Any) {
        
    }
    
    
    
}
