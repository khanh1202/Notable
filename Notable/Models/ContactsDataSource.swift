//
//  ContactsDataSource.swift
//  Notable
//
//  Created by Khanh Dinh on 6/2/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit
import Parse

// TODO: try to combine this class and NotesDataSource to a generic class

class ContactsDataSource: TableArrayDataSource<PFUser, ContactTableViewCell> {}

