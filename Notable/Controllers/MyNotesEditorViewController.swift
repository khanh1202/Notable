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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.parentToChildNoteEditor {
            let destinationVC = segue.destination as! NoteEditorViewController
            destinationVC.note = note
            destinationVC.mode = mode
        }
    }

}
