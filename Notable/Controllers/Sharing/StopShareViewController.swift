//
//  StopShareViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/5/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class StopShareViewController: UIViewController {

    @IBOutlet weak var sharingContactsTable: UITableView!
    private var datasource: ContactsDataSource!
    private var contactManager = ContactManager()
    private var selectedContacts: [PFUser] = []
    var note: Note!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactManager.delegate = self
        sharingContactsTable.delegate = self
        sharingContactsTable.isEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        contactManager.getUsersNoteIsShared(note)
    }
    

    @IBAction func stopShareExecute(_ sender: Any) {
        guard selectedContacts.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        contactManager.unshareToUsers(for: note, to: selectedContacts)
    }
}

extension StopShareViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedContact = datasource.item(at: indexPath) else {
            return
        }
        
        selectedContacts.append(selectedContact)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let deselectedContact = datasource.item(at: indexPath), let deselectedIndex = selectedContacts.firstIndex(of: deselectedContact) else {
            return
        }
        
        selectedContacts.remove(at: deselectedIndex)
    }
}

extension StopShareViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        datasource = ContactsDataSource(tableView: sharingContactsTable, items: contacts!)
        sharingContactsTable.reloadData()
        Spinner.stop()
    }
    
    func didFinishUnshareToUsers() {
        Spinner.stop()
        navigationController?.popToRootViewController(animated: true)
    }
}
