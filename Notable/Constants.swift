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
    static let objectIdField = "objectId"
    
    struct UserFields {
        static let displayNameField = "displayname"
        static let contacts = "contacts"
    }
    
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
        static let toSearchUsers = "toSearchUsers"
        static let toShareContacts = "toShareContacts"
        static let sharedToEditor = "sharedToEditor"
        static let sharedParentToEditor = "sharedParentToEditor"
        static let sharingToEditor = "sharingToEditor"
        static let sharingParentToEditor = "sharingParentToEditor"
        static let toStopShare = "toStopShare"
    }
    
    struct Images {
        static let trash = "trash"
        static let plus = "plus"
    }
    
    struct Messages {
        static let successfulDeleteNote = "Notes deleted successfully"
        static let successfulDeleteContact = "Contacts deleted successfully"
        static let selectNote = "Please select a note"
        static let selectContact = "Please select a contact"
        static let confirmShort = "Are you sure?"
        static let confirmDeleteNoteLong = "Are you sure want to delete notes?"
        static let confirmDeleteContactLong = "Are you sure want to delete contacts?"
    }
    
    struct Options {
        static let cancel = "Cancel"
        static let edit = "Edit"
        static let delete = "Delete"
    }
}
