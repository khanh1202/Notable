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
    let noteTableView: UITableView
    
    init(for tableView: UITableView, _ notes: [Note]) {
        self.notes = notes
        noteTableView = tableView
        super.init()
        noteTableView.dataSource = self
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
        cell.populateUI()
        return cell
    }
}

