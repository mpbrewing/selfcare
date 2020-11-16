//
//  RegistrationViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/12/20.
//

import Foundation
import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    var state = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        setupButtonStyle()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)
    }
    
    func setupButtonStyle() {
        CompletionButton.layer.cornerRadius = 15
        
        if state == 0 {
            CompletionButton.setTitle("Sign In", for: .normal)
            CompletionButton.setTitleColor(UIColor.white, for: .normal)
            CompletionButton.layer.borderWidth = 2
            CompletionButton.layer.borderColor = UIColor.white.cgColor
            CompletionButton.layer.backgroundColor = UIColor.black.cgColor
            titleLabel.text = "Let's sign you in."
            subtitleLabel.alpha = 1
            subtitleLabel2.alpha = 1
            alternateButton.setTitle("Don't have an account? Sign Up", for: .normal)

        } else if state == 1 {
            CompletionButton.setTitle("Sign Up", for: .normal)
            CompletionButton.setTitleColor(UIColor.black, for: .normal)
            CompletionButton.layer.borderWidth = 0
            CompletionButton.layer.backgroundColor = UIColor.white.cgColor
            titleLabel.text = "Let's create an account."
            subtitleLabel.alpha = 0
            subtitleLabel2.alpha = 0
            alternateButton.setTitle("Already have an account? Sign In", for: .normal)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel2: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func returnButton(_ sender: Any) {
        let loginView = LoginViewController()
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func emailDidChange(_ sender: Any) {
    }
    @IBAction func passwordDidChange(_ sender: Any) {
    }
    
    @IBOutlet weak var alternateButton: UIButton!
    @IBAction func alternateActionDown(_ sender: Any) {
        if state == 0 {
            SegueToRegistration(state: 1)
        } else {
            SegueToRegistration(state: 0)
        }
    }
    
    @IBOutlet weak var CompletionButton: UIButton!
    @IBAction func completionDown(_ sender: Any) {
        //SegueToHome()
        determineUserAction(state: state)
    }
    
    func SegueToRegistration(state: Int){
        let registrationView = RegistrationViewController()
        registrationView.modalPresentationStyle = .fullScreen
        registrationView.state = state
        self.present(registrationView, animated: true, completion: nil)
    }
    
    func SegueToHome(){
        let homeView = HomeViewControler()
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true, completion: nil)
    }
    
    func determineUserAction(state: Int){
        if state == 0 { //Sign In
            userAuthSignIn(email: emailTextfield.text ?? "", password: passwordTextfield.text ?? "")
        } else if state == 1 { //Sign Up
            userAuthSignUp(email: emailTextfield.text ?? "", password: passwordTextfield.text ?? "")
        }
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    //Logging In Requirements
    //isValidEmail
    //isValidPassword
    
    func userAuthSignIn(email: String, password: String)
    {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if error == nil && authResult != nil {
                    print("User logged in!")
                    if Auth.auth().currentUser != nil{
                        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                        self.SegueToHome()
                        }
                    }
                } else {
                    print("Error Logging in user: \(error!.localizedDescription)")
                }
        }
    }
    
    func userAuthSignUp(email: String, password: String)
    {
        Auth.auth().createUser(withEmail: email, password: password){ (authResult, error) in
            if error == nil && authResult != nil {
                print("User created and logged in!")
                self.SegueToHome()
            } else {
                print("Error Logging in user: \(error!.localizedDescription)")
            }
        }
    }
    
    
}
