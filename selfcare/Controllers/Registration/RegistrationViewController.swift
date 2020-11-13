//
//  RegistrationViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 11/12/20.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    var state = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        setupButtonStyle()
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
            alternateButton.titleLabel?.text = "Don't have an account? Sign Up"

        } else if state == 1 {
            CompletionButton.setTitle("Sign Up", for: .normal)
            CompletionButton.setTitleColor(UIColor.black, for: .normal)
            CompletionButton.layer.borderWidth = 0
            CompletionButton.layer.backgroundColor = UIColor.white.cgColor
            titleLabel.text = "Let's create an account."
            subtitleLabel.alpha = 0
            subtitleLabel2.alpha = 0
            alternateButton.titleLabel?.text = "Already have an account? Sign In"
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
    }
    
    @IBOutlet weak var CompletionButton: UIButton!
    @IBAction func completionDown(_ sender: Any) {
    }
    
    
    
}
