//
//  Note.swift
//  Notable
//
//  Created by Khanh Dinh on 5/28/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import Parse

class Note: PFObject, PFSubclassing {
    var title: String? {
        get {
            return self[K.NoteFields.title] as? String
        }
        set {
            self[K.NoteFields.title] = newValue
        }
    }
    
    var content: String? {
        get {
            return self[K.NoteFields.content] as? String
        }
        set {
            self[K.NoteFields.content] = newValue
        }
    }
    
    var createdAtTime: Date? {
        get {
            return self[K.NoteFields.createdAtTime] as? Date
        }
        set {
            self[K.NoteFields.createdAtTime] = newValue
        }
    }
    
    var author: PFUser? {
        get {
            return self[K.NoteFields.author] as? PFUser
        }
        set {
            self[K.NoteFields.author] = newValue
        }
    }
    
    var sharedTo: [PFUser]? {
        get {
            return self[K.NoteFields.sharedTo] as? [PFUser]
        }
        set {
            self[K.NoteFields.sharedTo] = newValue
        }
    }
    
    static func parseClassName() -> String {
        return "Note"
    }
    
    
}
