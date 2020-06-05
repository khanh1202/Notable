//
//  SharedNoteEditorVC.swift
//  Notable
//
//  Created by Khanh Dinh on 6/5/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class SharedNoteEditorVC: UIViewController {

    var note: Note!
    var mode: NoteEditorMode!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.sharedParentToEditor {
            let destinationVC = segue.destination as! NoteEditorViewController
            destinationVC.note = note
            destinationVC.mode = mode
        }
    }

}
