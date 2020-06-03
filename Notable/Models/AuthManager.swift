//
//  AuthManager.swift
//  Notable
//
//  Created by Khanh Dinh on 5/25/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import Parse

protocol AuthManagerLoginDelegate {
    func didLoginUser()
    func didFailLoginUser()
}

protocol AuthManagerSignupDelegate {
    func didSignupUser()
    func didFailSignupUser(message: String)
}

struct AuthManager {
    var loginDelegate: AuthManagerLoginDelegate?
    var signupDelegate: AuthManagerSignupDelegate?
    
    func logInNewSession(username: String, password: String) {
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if user != nil {
                self.loginDelegate?.didLoginUser()
            } else {
                self.loginDelegate?.didFailLoginUser()
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
            if succeeded {
                self.signupDelegate?.didSignupUser()
            } else {
                self.signupDelegate?.didFailSignupUser(message: error!.localizedDescription)
            }
        }
    }
    
    func logoutUser() {
        PFUser.logOut()
    }
}
