//
//  NoteManager.swift
//  Notable
//
//  Created by Khanh Dinh on 5/28/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import Parse

protocol NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note])
}

struct NoteManager {
    var delegate: NoteManagerDelegate?
    
    func getNotesOwnedByUser() {
        let query = PFQuery(className: Note.parseClassName())
        if let user = PFUser.current() {
            query.whereKey(K.NoteFields.author, equalTo: user)
            
            query.findObjectsInBackground { (notes, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let notes = notes as? [Note] {
                    self.delegate?.didGetNotesFromServer(notes)
                }
            }
        }
    }
    
    func getNotesSharedByUser() {
        let noteQuery = PFQuery(className: Note.parseClassName())
        if let user = PFUser.current() {
            noteQuery.whereKeyExists(K.NoteFields.sharedTo).whereKey(K.NoteFields.author, equalTo: user)
            
            noteQuery.findObjectsInBackground { (notes, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let notes = notes as? [Note] {
                    self.delegate?.didGetNotesFromServer(notes)
                }
            }
        }
    }
    
    func getNotesShareToUser() {
        let noteQuery = PFQuery(className: Note.parseClassName())
        if let user = PFUser.current() {
            noteQuery.whereKey("sharedTo", containsAllObjectsIn: [user])
        }
        
        noteQuery.findObjectsInBackground { (notes, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let notes = notes as? [Note] {
                self.delegate?.didGetNotesFromServer(notes)
            }
        }
    }
}
