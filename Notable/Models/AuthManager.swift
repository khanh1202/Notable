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
}
