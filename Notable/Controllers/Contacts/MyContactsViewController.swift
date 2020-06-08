//
//  MyContactsViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class MyContactsViewController: MultiSelectTable<PFUser, ContactTableViewCell> {

    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var editCancelItem: UIBarButtonItem!
    @IBOutlet weak var addDeleteItem: UIBarButtonItem!
    private var contactManager = ContactManager()
    
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
        selectedItems = []
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
        
        guard selectedItems.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        presentDeleteActionSheet(shortMessage: K.Messages.confirmShort, longMessage: K.Messages.confirmDeleteContactLong) {
            Spinner.start()
            self.contactManager.deleteContacts(contacts: self.selectedItems)
            self.toggleEditMode()
        }
    }
}

extension MyContactsViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        datasource = ContactsDataSource(tableView: contactTableView, items: contacts!)
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
