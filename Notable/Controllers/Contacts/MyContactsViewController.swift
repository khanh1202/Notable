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
    
    func createOneContact() {
        guard let user = PFUser.current() else { return }
        let query = PFQuery(className: PFUser.parseClassName())
        query.getObjectInBackground(withId: "xRri69lYyz") { (magisk, error) in
            if let magisk = magisk as? PFUser {
                user.addUniqueObject(magisk, forKey: "contacts")
                user.saveInBackground { (ok, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("contacted")
                    }
                }
            } else {
                print(error?.localizedDescription ?? "")
            }
        }

        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        contactManager.getContactsCurrentUser()
    }
    
    @IBAction func editCancelExecute(_ sender: Any) {
    }
    
    @objc func addExecute() {
//        performSegue(withIdentifier: K.Segues.addToNoteEditor, sender: self)
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
        
    }
}

extension MyContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

extension MyContactsViewController: ContactManagerDelegate {
    func didGetContactsFromServer(_ contacts: [PFUser]?) {
        datasource = ContactsDataSource(for: contactTableView, contacts)
        contactTableView.reloadData()
        Spinner.stop()
    }
}
