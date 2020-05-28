//
//  NotesDataSource.swift
//  Notable
//
//  Created by Khanh Dinh on 5/29/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class NotesDataSource: NSObject {
    var notes: [Note]
    let noteManager: NoteManager
    let noteTableView: UITableView
    let tableType: NoteTableType
    
    init(for tableView: UITableView, type tableType: NoteTableType) {
        notes = []
        noteManager = NoteManager()
        noteTableView = tableView
        self.tableType = tableType
        
        switch tableType {
        case .ownedByUser:
            noteManager.getNotesOwnedByUser()
        case .sharedByUser:
            noteManager.getNotesSharedByUser()
        default:
            noteManager.getNotesShareToUser()
        }
    }
    
    func registerCell()  {
        noteTableView.register(UINib(nibName: K.noteNibName, bundle: nil), forCellReuseIdentifier: K.noteCellIdentifier)
    }
}

extension NotesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.noteCellIdentifier, for: indexPath) as! NoteTableViewCell
        cell.note = notes[indexPath.row]
        cell.tableType = self.tableType
        return cell
    }
}

extension NotesDataSource: NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {
        self.notes = notes
        noteTableView.reloadData()
    }
    
}
