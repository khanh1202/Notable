//
//  MyNotesViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/29/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class MyNotesViewController: UIViewController {

    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var shareBarItem: UIBarButtonItem!
    @IBOutlet weak var leftBarItem: UIBarButtonItem!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    private var datasource: NotesDataSource!
    private var noteManager = NoteManager()
    private var selectedNotes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteManager.delegate = self
        notesTableView.delegate = self
        updateBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        selectedNotes = []
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
    }
    
    @objc func deleteExecute() {
        guard notesTableView.isEditing else {
            return
        }
        
        guard selectedNotes.count > 0 else {
            showToast(message: K.Messages.selectNote, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        // TODO: if time is available, refactor the below to a utility method to display alert
        let deleteAlert = UIAlertController(title: K.Messages.confirmShort, message: K.Messages.confirmDeleteLong, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: K.Options.delete, style: .destructive) { (action) in
            self.noteManager.deleteNotes(notes: self.selectedNotes)
            self.toggleEditMode()
        }
        let cancelAction = UIAlertAction(title: K.Options.cancel, style: .cancel, handler: nil)
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        present(deleteAlert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segues.addToNoteEditor:
            let destinationVC = segue.destination as! MyNotesEditorViewController
            destinationVC.mode = .adding
        default:
            let destinationVC = segue.destination as! MyNotesEditorViewController
            destinationVC.note = datasource.selectedNote
            destinationVC.mode = .editing
        }
    }

}

extension MyNotesViewController: NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {
        datasource = NotesDataSource(for: notesTableView, notes)
        notesTableView.reloadData()
    }
    
    func didFinishDeletingNotes() {
        noteManager.getNotesOwnedByUser()
        showToast(message: K.Messages.successfulDelete, font: UIFont.systemFont(ofSize: 15))
    }
}

extension MyNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedNote = datasource.getNote(at: indexPath.row) else {
            return
        }
        
        if !tableView.isEditing {
            performSegue(withIdentifier: K.Segues.noteToEditor, sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            selectedNotes.append(selectedNote)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else {
            return
        }
        
        guard let deselectedNote = datasource.getNote(at: indexPath.row), let deselectedIndex = selectedNotes.firstIndex(of: deselectedNote) else {
            return
        }
        
        selectedNotes.remove(at: deselectedIndex)
    }

}

