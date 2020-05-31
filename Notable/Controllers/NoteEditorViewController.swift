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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
