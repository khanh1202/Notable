//
//  AddContactsViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/3/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class AddContactsViewController: MultiSelectTable<PFUser, ContactTableViewCell> {

    @IBOutlet weak var nameSearchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    private var contactManager = ContactManager()
    private var searchingTerm: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        contactManager.delegate = self
        nameSearchBar.delegate = self
        usersTableView.delegate = self
        usersTableView.isEditing = true
    }
    
    @IBAction func addExecute(_ sender: Any) {
        guard selectedItems.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        Spinner.start()
        contactManager.addUsersToContacts(newContacts: selectedItems)
    }

}

extension AddContactsViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        guard let contacts = contacts, contacts.count > 0 else {
            Spinner.stop()
            showToast(message: "No user found", font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        datasource = ContactsDataSource(tableView: usersTableView, items: contacts)
        usersTableView.reloadData()
        Spinner.stop()
    }
    
    func didFinishAndReadyBack() {
        Spinner.stop()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension AddContactsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchingTerm = searchBar.text ?? ""
        guard searchingTerm != "" else {
            showToast(message: "Please enter something to search", font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        Spinner.start()
        contactManager.searchUsersToContact(name: searchingTerm)
    }
}
