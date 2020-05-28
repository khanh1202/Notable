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
    var tableType: NoteTableType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
