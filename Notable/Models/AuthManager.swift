//
//  AuthManager.swift
//  Notable
//
//  Created by Khanh Dinh on 5/25/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import Parse

protocol AuthManagerDelegate {
    func didLoginUser()
    func didFailLoginUser()
    func didSignupUser()
    func didFailSignupUser(message: String)
}

extension AuthManagerDelegate {
    func didLoginUser() {}
    func didFailLoginUser() {}
    func didSignupUser() {}
    func didFailSignupUser(message: String) {}
}

struct AuthManager {
    var delegate: AuthManagerDelegate?
    
    func logInNewSession(username: String, password: String) {
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if user != nil {
                self.delegate?.didLoginUser()
            } else {
                self.delegate?.didFailLoginUser()
            }
        }
    }
    
    func isReturningUser() -> Bool {
        return PFUser.current() != nil
    }
    
    func signUpUser(_ username: String, _ displayName: String, _ email: String, _ password: String) {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user.displayname = displayName
        
        user.signUpInBackground { (succeeded, error) in
            if let error = error {
                self.delegate?.didFailSignupUser(message: error.localizedDescription)
            } else {
                self.delegate?.didSignupUser()
            }
        }
    }
    
    func logoutUser() {
        PFUser.logOut()
    }
}
