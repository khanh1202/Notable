//
//  AddContactsViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/3/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class AddContactsViewController: UIViewController {

    @IBOutlet weak var nameSearchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    private var datasource: ContactsDataSource!
    private var contactManager = ContactManager()
    private var selectedUsers: [PFUser] = []
    private var searchingTerm: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        contactManager.delegate = self
        nameSearchBar.delegate = self
        usersTableView.delegate = self
        usersTableView.isEditing = true
    }
    
    @IBAction func addExecute(_ sender: Any) {
        guard selectedUsers.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        Spinner.start()
        contactManager.addUsersToContacts(newContacts: selectedUsers)
    }

}

extension AddContactsViewController: ContactManagerDelegate {
    func didFinishSearchingUsers(users: [PFUser]?) {
        guard let users = users, users.count > 0 else {
            Spinner.stop()
            showToast(message: "No user found", font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        datasource = ContactsDataSource(for: usersTableView, users)
        usersTableView.reloadData()
        Spinner.stop()
    }
    
    func didAddUsersToContacts() {
        Spinner.stop()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension AddContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else { return }
        
        guard let selectedUser = datasource.getContact(at: indexPath.row) else {
            return
        }
        
        selectedUsers.append(selectedUser)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else { return }
        
        guard let deselectedUser = datasource.getContact(at: indexPath.row), let deselectedIndex = selectedUsers.firstIndex(of: deselectedUser) else {
            return
        }
        
        selectedUsers.remove(at: deselectedIndex)
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
