//
//  NoteEditorViewController.swift
//  Notable
//
//  Created by Khanh Dinh on 5/30/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController {

    @IBOutlet weak var titleTextField: PaddingTextField!
    @IBOutlet weak var timeAndAuthorTextField: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: Note?
    var mode = NoteEditorMode.viewing
    var noteManager = NoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteManager.delegate = self
        initializeUI()
    }
    
    func initializeUI() {
        if let note = note {
            titleTextField.text = note.title
            timeAndAuthorTextField.text = "Created: \(note.createdAtTimeString) by \(note.author![K.displayNameField] as! String)"
            contentTextView.text = note.content
        }
        
        switch mode {
        case .viewing:
            titleTextField.isEnabled = false
            contentTextView.isEditable = false
        case .adding:
            timeAndAuthorTextField.isHidden = true
        case .editing:
            timeAndAuthorTextField.isHidden = false
        }
    }

    func saveNote() {
        noteManager.prepareNoteAndSave(existingNote: note, newTitle: titleTextField.text, newContent: contentTextView.text)
    }
}

extension NoteEditorViewController: NoteManagerDelegate {
    func didFinishSaveNote() {
        navigationController?.popToRootViewController(animated: true)
    }
}
