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
    func didFinishSaveNote()
    func didFinishDeletingNotes()
    func didFinishSharingNotes()
}

extension NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {}
    func didFinishSaveNote() {}
    func didFinishDeletingNotes() {}
    func didFinishSharingNotes() {}
}

struct NoteManager {
    var delegate: NoteManagerDelegate?
    
    func getNotesOwnedByUser() {
        guard let user = PFUser.current() else {
            return
        }
        
        let query = PFQuery(className: Note.parseClassName())
        query.whereKey(K.NoteFields.author, equalTo: user)
        
        query.findObjectsInBackground { (notes, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let notes = notes as? [Note] {
                self.delegate?.didGetNotesFromServer(notes)
            }
        }
    }
    
    func getNotesSharedByUser() {
        guard let user = PFUser.current() else {
            return
        }
        
        let noteQuery = PFQuery(className: Note.parseClassName())
        noteQuery.whereKeyExists(K.NoteFields.sharedTo).whereKey(K.NoteFields.author, equalTo: user)
        
        noteQuery.findObjectsInBackground { (notes, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let notes = notes as? [Note] {
                self.delegate?.didGetNotesFromServer(notes)
            }
        }
    }
    
    func getNotesSharedToUser() {
        guard let user = PFUser.current() else {
            return
        }
        
        let noteQuery = PFQuery(className: Note.parseClassName())
            .whereKey(K.NoteFields.sharedTo, containsAllObjectsIn: [user])
        
        noteQuery.findObjectsInBackground { (notes, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let notes = notes as? [Note] {
                self.delegate?.didGetNotesFromServer(notes)
            }
        }
    }
    
    func prepareNoteAndSave(existingNote: Note?, newTitle: String?, newContent: String?) {
        if let existingNote = existingNote {
            existingNote.title = newTitle
            existingNote.content = newContent
            saveNote(note: existingNote)
        } else {
            let newNote = Note()
            newNote.title = newTitle
            newNote.content = newContent
            newNote.createdAtTime = Date()
            newNote.author = PFUser.current()
            saveNote(note: newNote)
        }
    }
    
    func deleteNotes(notes: [Note]) {
        PFObject.deleteAll(inBackground: notes) { (suceeded, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.delegate?.didFinishDeletingNotes()
            }
        }
    }
    
    private func saveNote(note: Note) {
        note.saveInBackground { (succeeded, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.delegate?.didFinishSaveNote()
            }
        }
    }
    
    func shareNotesToUsers(notes: [Note], users: [PFUser]) {
        let dispatchGroup = DispatchGroup()
        for note in notes {
            dispatchGroup.enter()
            note.addUniqueObjects(from: users, forKey: K.NoteFields.sharedTo)
            note.saveInBackground { (ok, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didFinishSharingNotes()
        }
    }
}
