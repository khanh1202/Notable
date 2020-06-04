//
//  MyContactsViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class MyContactsViewController: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var editCancelItem: UIBarButtonItem!
    @IBOutlet weak var addDeleteItem: UIBarButtonItem!
    private var datasource: ContactsDataSource!
    private var contactManager = ContactManager()
    private var selectedContacts: [PFUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactManager.delegate = self
        contactTableView.delegate = self
        updateBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        contactManager.getContactsCurrentUser { (contacts) in
            self.didGetContactsFromServer(contacts)
        }
    }
    
    @IBAction func editCancelExecute(_ sender: Any) {
        toggleEditMode()
    }
    
    @objc func addExecute() {
        performSegue(withIdentifier: K.Segues.toSearchUsers, sender: self)
    }
    
    func toggleEditMode() {
        contactTableView.setEditing(!contactTableView.isEditing, animated: true)
        
        updateBarItems()
        selectedContacts = []
    }
    
    func updateBarItems() {
        let editing = contactTableView.isEditing
        addDeleteItem.target = self

        editCancelItem.title = editing ? K.Options.cancel : K.Options.edit
        addDeleteItem.image = editing ? UIImage(systemName: K.Images.trash) : UIImage(systemName: K.Images.plus)
        addDeleteItem.action = editing ? #selector(self.deleteExecute) : #selector(self.addExecute)
    }
    
    @objc func deleteExecute() {
        guard contactTableView.isEditing else {
            return
        }
        
        guard selectedContacts.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        // TODO: if time is available, refactor the below to a utility method to display alert
        let deleteAlert = UIAlertController(title: K.Messages.confirmShort, message: K.Messages.confirmDeleteContactLong, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: K.Options.delete, style: .destructive) { (action) in
            Spinner.start()
            self.contactManager.deleteContacts(contacts: self.selectedContacts)
            self.toggleEditMode()
        }
        let cancelAction = UIAlertAction(title: K.Options.cancel, style: .cancel, handler: nil)
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        present(deleteAlert, animated: true, completion: nil)
    }
}

extension MyContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else {
            return
        }
        
        guard let selectedContact = datasource.getContact(at: indexPath.row) else {
            return
        }
        
        selectedContacts.append(selectedContact)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else {
            return
        }
        
        guard let deselectedContact = datasource.getContact(at: indexPath.row), let deselectedIndex = selectedContacts.firstIndex(of: deselectedContact) else {
            return
        }
        
        selectedContacts.remove(at: deselectedIndex)
    }
}

extension MyContactsViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        datasource = ContactsDataSource(for: contactTableView, contacts)
        contactTableView.reloadData()
        Spinner.stop()
    }
    
    func didFinishRemoveContacts() {
        contactManager.getContactsCurrentUser { (contacts) in
            self.didGetContactsFromServer(contacts)
        }
        showToast(message: K.Messages.successfulDeleteContact, font: UIFont.systemFont(ofSize: 15))
    }
}
