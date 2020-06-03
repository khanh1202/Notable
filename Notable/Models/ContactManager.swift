//
//  ContactManager.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import Parse

protocol ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?)
}

struct ContactManager {
    var delegate: ContactManagerDelegate?
    
    func getContactsCurrentUser() {
        guard let user = PFUser.current() else {
            return
        }
        
        let userQuery = PFQuery(className: PFUser.parseClassName())
            .whereKey("objectId", equalTo: user.objectId!)
            .includeKey("contacts")
        userQuery.getFirstObjectInBackground(block: { (fetchedUser, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let fetchedUser = fetchedUser as? PFUser {
                let contacts = fetchedUser.object(forKey: K.UserFields.contacts) as? [PFUser]
                self.delegate?.didGetContactsFromServer(contacts)
            }
        })
    }
}
