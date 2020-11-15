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

    @IBAction func SignUpButtonDown(_ sender: UIButton) {
        SegueToRegistration(state: 1)
    }
    
    @IBAction func SignInButtonDown(_ sender: UIButton) {
        SegueToRegistration(state: 0)
    }
    
    func SegueToRegistration(state: Int){
        let registrationView = RegistrationViewController()
        registrationView.modalPresentationStyle = .fullScreen
        registrationView.state = state
        self.present(registrationView, animated: true, completion: nil)
    }
    
}
