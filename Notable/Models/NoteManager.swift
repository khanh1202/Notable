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
    func didFinishAndReadyBack()
    func didFinishDeletingNotes()
}

extension NoteManagerDelegate {
    func didGetNotesFromServer(_ notes: [Note]) {}
    func didFinishAndReadyBack() {}
    func didFinishDeletingNotes() {}
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
            .whereKey(K.NoteFields.author, equalTo: user)
            .whereKeyExists(K.NoteFields.sharedTo)
        
        noteQuery.findObjectsInBackground { (unfilteredNotes, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let unfilteredNotes = unfilteredNotes as? [Note] {
                let notes = unfilteredNotes.filter { (note) -> Bool in
                    if let usersShared = note.object(forKey: K.NoteFields.sharedTo) as? [PFUser] {
                        return usersShared != []
                    }
                    
                    return false
                }
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
        
        guard let newContent = newContent else {
            return
        }
        
        ClassifierManager.predictSentiment(of: newContent)
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
                self.delegate?.didFinishAndReadyBack()
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
            self.delegate?.didFinishAndReadyBack()
        }
    }
}
