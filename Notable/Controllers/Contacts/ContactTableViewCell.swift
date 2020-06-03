//
//  ContactTableViewCell.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var contact: PFUser?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        populateUI()
    }
    
    func populateUI() {
        guard let contact = contact else {
            return
        }
        
        avatarImage.image = contact.avatar
        displayNameLabel.text = contact.displayname
        usernameLabel.text = contact.username
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
