//
//  SignupViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/25/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: PaddingTextField!
    @IBOutlet weak var displayNameTextField: PaddingTextField!
    @IBOutlet weak var emailTextField: PaddingTextField!
    @IBOutlet weak var passwordTextField: PaddingTextField!
    
    var viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        displayNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        viewModel.authManager.signupDelegate = self
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        saveDataToViewModel()
        if viewModel.isFormValid() {
            Spinner.start()
            viewModel.signUpUser()
        } else {
            createAlert(title: "Invalid Info", message: "Please enter all fields to proceed")
        }
    }
    
    func saveDataToViewModel() {
        viewModel.username = usernameTextField.text
        viewModel.displayName = displayNameTextField.text
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SignupViewController: AuthManagerSignupDelegate {
    func didSignupUser() {
        Spinner.stop()
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        if let initialialVC = storyBoard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialialVC
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    func didFailSignupUser(message: String) {
        Spinner.stop()
        createAlert(title: "Signup Failed", message: message)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
