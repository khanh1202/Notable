//
//  MyNotesEditorViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/30/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class MyNotesEditorViewController: UIViewController {

    var note: Note?
    var mode = NoteEditorMode.viewing
    var noteEditorController: NoteEditorViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        noteEditorController.saveNote()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.parentToChildNoteEditor {
            noteEditorController = segue.destination as? NoteEditorViewController
            noteEditorController.note = note
            noteEditorController.mode = mode
        }
    }

}
