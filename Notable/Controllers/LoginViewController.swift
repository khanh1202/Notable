//
//  ViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/24/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var authManager = AuthManager()
    
    override func viewDidLoad() {
        authManager.delegate = self
        logInReturningUser()
    }
    
    func logInReturningUser() {
        if authManager.isReturningUser() {
            print("User should be able to proceed")
        }
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            authManager.logInNewSession(username: username, password: password)
        }
    }
}

extension LoginViewController: AuthManagerDelegate {
    func didLoginUser() {
        print("Login success")
    }
    
    func didFailLoginUser() {
        let alert = UIAlertController(title: "Authentication failed", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

