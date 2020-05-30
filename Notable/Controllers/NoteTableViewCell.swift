//
//  NoteTableViewCell.swift
//  Notable
//
//  Created by Khanh Dinh on 5/27/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteBriefLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var note: Note?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        populateUI()
    }
    
    func populateUI() {
        if let note = note {
            noteTitleLabel.text = note.title
            noteBriefLabel.text = note.content
            dateCreatedLabel.text = note.createdAtTimeString
            authorLabel.text = note.author![K.displayNameField] as? String
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
