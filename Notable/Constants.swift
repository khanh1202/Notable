//
//  Constants.swift
//  Notable
//
//  Created by Khanh Dinh on 5/25/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//
import UIKit

struct K {
    static let borderWidth: CGFloat = 3
    static let borderColor: CGColor = #colorLiteral(red: 0.2295364141, green: 0.3173942268, blue: 0.3103998899, alpha: 1)
    static let displayNameField = "displayname"
    static let noteNibName = "NoteTableViewCell"
    static let noteCellIdentifier = "noteCellIdentifier"
    
    struct NoteFields {
        static let title = "title"
        static let content = "content"
        static let createdAtTime = "createdAtTime"
        static let author = "author"
        static let sharedTo = "sharedTo"
    }
    
    struct Segues {
        static let noteToEditor = "noteToEditor"
        static let addToNoteEditor = "addToNoteEditor"
        static let parentToChildNoteEditor = "parentToChildNoteEditor"
    }
    
    struct Images {
        static let trash = "trash"
        static let plus = "plus"
    }
    
    struct Messages {
        static let successfulDelete = "Notes deleted successfully"
        static let selectNote = "Please select a note"
        static let confirmShort = "Are you sure?"
        static let confirmDeleteLong = "Are you sure want to delete notes?"
    }
    
    struct Options {
        static let cancel = "Cancel"
        static let edit = "Edit"
        static let delete = "Delete"
    }
}
