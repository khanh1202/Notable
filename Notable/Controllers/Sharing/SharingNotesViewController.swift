//
//  SharingNotesViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/5/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class SharingNotesViewController: UIViewController {

    @IBOutlet weak var sharingNotesTable: UITableView!
    @IBOutlet weak var editCancelItem: UIBarButtonItem!
    @IBOutlet weak var stopShareItem: UIBarButtonItem!
    var noteManager = NoteManager()
    var datasource: NotesDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        noteManager.delegate = self
        sharingNotesTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        noteManager.getNotesSharedByUser()
    }
    
    @IBAction func editCancelExecute(_ sender: Any) {
        toggleEditMode()
    }
    
    @IBAction func stopShareExecute(_ sender: Any) {
        guard datasource.selectedItem != nil else {
            showToast(message: K.Messages.selectNote, font: UIFont.systemFont(ofSize: 15))
            return
        }
        
        performSegue(withIdentifier: K.Segues.toStopShare, sender: self)
    }
    
    func toggleEditMode() {
        sharingNotesTable.setEditing(!sharingNotesTable.isEditing, animated: true)
        let editting = sharingNotesTable.isEditing
        
        editCancelItem.title = editting ? "Cancel" : "Edit"
        stopShareItem.isEnabled = editting
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segues.sharingToEditor:
            let destinationVC = segue.destination as! SharingNoteEditorVC
            destinationVC.note = datasource.selectedItem
            destinationVC.mode = .viewing
        default:
            let destinationVC = segue.destination as! StopShareViewController
            destinationVC.note = datasource.selectedItem!
        }
    }

}

extension SharingNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            performSegue(withIdentifier: K.Segues.sharingToEditor, sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
}

extension SharingNotesViewController: NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {
        datasource = NotesDataSource(tableView: sharingNotesTable, items: notes)
        sharingNotesTable.reloadData()
        Spinner.stop()
    }
}

