//
//  ShareNoteViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/4/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class ShareNoteViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    var notes: [Note]!
    private var datasource: ContactsDataSource!
    private var contactManager = ContactManager()
    private var noteManager = NoteManager()
    private var selectedContacts: [PFUser] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        contactManager.delegate = self
        noteManager.delegate = self
        contactsTableView.delegate = self
        contactsTableView.isEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        contactManager.getContactsCurrentUser { (contacts) in
            self.didGetContactsFromServer(contacts)
        }
    }
    

    @IBAction func shareExecute(_ sender: Any) {
        guard selectedContacts.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        Spinner.start()
        noteManager.shareNotesToUsers(notes: notes, users: selectedContacts)
    }
    
}

extension ShareNoteViewController: UITableViewDelegate {
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

extension ShareNoteViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        datasource = ContactsDataSource(tableView: contactsTableView, items: contacts!)
        contactsTableView.reloadData()
        Spinner.stop()
    }
}

extension ShareNoteViewController: NoteManagerDelegate {
    func didFinishSharingNotes() {
        Spinner.stop()
        navigationController?.popToRootViewController(animated: true)
    }
}
