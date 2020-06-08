//
//  StopShareViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/5/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class StopShareViewController: MultiSelectTable<PFUser, ContactTableViewCell> {

    @IBOutlet weak var sharingContactsTable: UITableView!
    private var contactManager = ContactManager()
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
        guard selectedItems.count > 0 else {
            showToast(message: K.Messages.selectContact, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        contactManager.unshareToUsers(for: note, to: selectedItems)
    }
}

extension StopShareViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        datasource = ContactsDataSource(tableView: sharingContactsTable, items: contacts!)
        sharingContactsTable.reloadData()
        Spinner.stop()
    }
    
    func didFinishAndReadyBack() {
        Spinner.stop()
        navigationController?.popToRootViewController(animated: true)
    }
}
