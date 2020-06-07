//
//  SignupViewModel.swift
//  Notable
//
//  Created by Khanh Dinh on 5/25/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation

class SignupViewModel {
    var username: String?
    var displayName: String?
    var email: String?
    var password: String?
    var successfulSignupClosure: (() -> ())?
    var failSignupClosure: ((String) -> ())?
    var authManager: AuthManager
    
    init() {
        authManager = AuthManager()
        authManager.delegate = self
    }
    
    func isFormValid() -> Bool {
        guard let username = username, let displayName = displayName, let email = email, let password = password else {
            return false
        }
        
        if (username == "" || displayName == "" || email == "" || password == "") {
            return false
        }
        
        return true
    }
    
    func signUpUser() {
        authManager.signUpUser(username!, displayName!, email!, password!)
    }
}

extension SignupViewModel: AuthManagerDelegate {
    func didSignupUser() {
        successfulSignupClosure?()
    }
    
    func didFailSignupUser(message: String) {
        failSignupClosure?(message)
    }
}
