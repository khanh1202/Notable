//
//  MyNotesViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/29/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class MyNotesViewController: MultiSelectTable<Note, NoteTableViewCell> {

    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var shareBarItem: UIBarButtonItem!
    @IBOutlet weak var leftBarItem: UIBarButtonItem!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    private var noteManager = NoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteManager.delegate = self
        notesTableView.delegate = self
        selectItemClosure = displaySelectedNote(at:)
        updateBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        noteManager.getNotesOwnedByUser()
    }
    
    @objc func addExecute() {
        performSegue(withIdentifier: K.Segues.addToNoteEditor, sender: self)
    }
    
    @IBAction func editCancelExecute(_ sender: Any) {
        toggleEditMode()
    }
    
    func toggleEditMode() {
        notesTableView.setEditing(!notesTableView.isEditing, animated: true)
        
        updateBarItems()
        selectedItems = []
    }
    
    func updateBarItems() {
        let editing = notesTableView.isEditing
        rightBarItem.target = self

        leftBarItem.title = editing ? K.Options.cancel : K.Options.edit
        rightBarItem.image = editing ? UIImage(systemName: K.Images.trash) : UIImage(systemName: K.Images.plus)
        rightBarItem.action = editing ? #selector(self.deleteExecute) : #selector(self.addExecute)
        shareBarItem.isEnabled = editing
    }
    
    @IBAction func shareExecute(_ sender: Any) {
        guard selectedItems.count > 0 else {
            showToast(message: K.Messages.selectNote, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        performSegue(withIdentifier: K.Segues.toShareContacts, sender: self)
        self.toggleEditMode()
    }
    
    @objc func deleteExecute() {
        guard notesTableView.isEditing else {
            return
        }
        
        guard selectedItems.count > 0 else {
            showToast(message: K.Messages.selectNote, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        presentDeleteActionSheet(shortMessage: K.Messages.confirmShort, longMessage: K.Messages.confirmDeleteNoteLong) {
            Spinner.start()
            self.noteManager.deleteNotes(notes: self.selectedItems)
            self.toggleEditMode()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segues.addToNoteEditor:
            let destinationVC = segue.destination as! MyNotesEditorViewController
            destinationVC.mode = .adding
        case K.Segues.toShareContacts:
            let destinationVC = segue.destination as! ShareNoteViewController
            destinationVC.notes = selectedItems
        default:
            let destinationVC = segue.destination as! MyNotesEditorViewController
            destinationVC.note = datasource.selectedItem
            destinationVC.mode = .editing
        }
    }
    
    func displaySelectedNote(at indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segues.noteToEditor, sender: self)
        notesTableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MyNotesViewController: NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {
        datasource = NotesDataSource(tableView: notesTableView, items: notes)
        notesTableView.reloadData()
        Spinner.stop()
    }
    
    func didFinishDeletingNotes() {
        noteManager.getNotesOwnedByUser()
        showToast(message: K.Messages.successfulDeleteContact, font: UIFont.systemFont(ofSize: 15))
    }
}

