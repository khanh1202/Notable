//
//  ProfileViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/27/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    let currentUser = PFUser.current()
    let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = currentUser {
            displayNameLabel.text = currentUser.displayname
            usernameLabel.text = currentUser.username
            emailLabel.text = currentUser.email
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        authManager.logoutUser()
        
        redirectTo(storyboard: K.loginStoryBoard, bundle: nil)
    }
    
}
