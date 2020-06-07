//
//  SharedNotesViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 6/5/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class SharedNotesViewController: UIViewController {

    @IBOutlet weak var sharedNotesTable: UITableView!
    var noteManager = NoteManager()
    var datasource: NotesDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        noteManager.delegate = self
        sharedNotesTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Spinner.start()
        noteManager.getNotesSharedToUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.sharedToEditor {
            let destinationVC = segue.destination as! SharedNoteEditorVC
            destinationVC.note = datasource.selectedItem
            destinationVC.mode = .viewing
        }
    }

}

extension SharedNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segues.sharedToEditor, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SharedNotesViewController: NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {
        datasource = NotesDataSource(tableView: sharedNotesTable, items: notes)
        sharedNotesTable.reloadData()
        Spinner.stop()
    }
}
