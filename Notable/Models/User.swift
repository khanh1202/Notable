//
//  User.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import Parse

extension PFUser {
    var displayname: String? {
        get {
            return self[K.UserFields.displayNameField] as? String
        }
        set {
            self[K.UserFields.displayNameField] = newValue
        }
    }
    
    var contacts: [PFUser]? {
        get {
            return self[K.UserFields.contacts] as? [PFUser]
        }
        set {
            self[K.UserFields.contacts] = newValue
        }
    }
    
    var avatar: UIImage? {
        let suffix = ".circle"
        guard let namePrefix = displayname?.prefix(1).lowercased(), let image = UIImage(systemName: namePrefix + suffix) else {
            return UIImage(systemName: "questionmark\(suffix)")
        }
        
        return image
    }
}
