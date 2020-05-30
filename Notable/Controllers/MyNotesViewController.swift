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
    var datasource: NotesDataSource!
    var noteManager = NoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testOneSimpleNote()
        noteManager.delegate = self
        noteManager.getNotesOwnedByUser()
    }
    
    func testOneSimpleNote() {
        let note = Note()
        note.title = "One experience"
        note.content = "Today i have a dream"
        note.author = PFUser.current()
        note.createdAtTime = Date()
        
        note.saveInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyNotesViewController: NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {
        datasource = NotesDataSource(for: notesTableView, notes)
        datasource.noteTableView.reloadData()
    }
}
