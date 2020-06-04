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
    func didFinishRemoveContacts()
    func didFinishSearchingUsers(users: [PFUser]?)
    func didAddUsersToContacts()
}

extension ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {}
    func didFinishRemoveContacts() {}
    func didFinishSearchingUsers(users: [PFUser]?) {}
    func didAddUsersToContacts() {}
}

struct ContactManager {
    var delegate: ContactManagerDelegate?
    
    func getContactsCurrentUser(handler: @escaping ([PFUser]?) -> Void) {
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
                handler(contacts)
            }
        })
    }
    
    func deleteContacts(contacts: [PFUser]) {
        guard let user = PFUser.current() else { return }
        user.removeObjects(in: contacts, forKey: K.UserFields.contacts)
        user.saveInBackground { (successful, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.delegate?.didFinishRemoveContacts()
            }
        }
    }
    
    func searchUsersToContact(name: String) {
        let queryName = PFQuery(className: PFUser.parseClassName())
            .whereKey(K.UserFields.displayNameField, matchesRegex: name, modifiers: "i")
        
        getContactsCurrentUser { (contacts) in
            let userIds = (contacts ?? []).map { $0.objectId ?? ""}
            queryName.whereKey(K.objectIdField, notContainedIn: userIds)
            queryName.findObjectsInBackground { (potentialContacts, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.delegate?.didFinishSearchingUsers(users: potentialContacts as? [PFUser])
                }
            }
        }
    }
    
    func addUsersToContacts(newContacts: [PFUser]) {
        guard let user = PFUser.current() else { return }
        
        user.addUniqueObjects(from: newContacts, forKey: K.UserFields.contacts)
        user.saveInBackground { (ok, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.delegate?.didAddUsersToContacts()
            }
        }
    }
}
