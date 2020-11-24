//
//  LoginViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/10/20.
//

import UIKit
import Foundation
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "LoginView")
        setupButtonStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleFirebaseAuth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func handleFirebaseAuth()
    {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("User logged in")
                self.SegueToHome()
            } else {
                print("User not logged in")
            }
        }
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
    
    func SegueToHome(){
        let homeView = HomeViewController()
        homeView.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: homeView)
    }
    
}

