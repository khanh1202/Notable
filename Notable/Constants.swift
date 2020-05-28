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
}
