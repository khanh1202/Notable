//
//  ContactsDataSource.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

// TODO: try to combine this class and NotesDataSource to a generic class

class ContactsDataSource: NSObject {
    private var contacts: [PFUser]
    private var contactTableView: UITableView
    
    init(for tableView: UITableView, _ contacts: [PFUser]?) {
        self.contacts = contacts ?? []
        contactTableView = tableView
        super.init()
        contactTableView.dataSource = self
        contactTableView.register(UINib(nibName: K.contactNibName, bundle: nil), forCellReuseIdentifier: K.contactCellIdentifier)
    }
    
    func getContact(at index: Int) -> PFUser? {
        guard index >= 0 && index < contacts.count else {
            return nil
        }
        
        return contacts[index]
    }
}

extension ContactsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.contactCellIdentifier, for: indexPath) as! ContactTableViewCell
        cell.contact = contacts[indexPath.row]
        cell.populateUI()
        return cell
    }
}
