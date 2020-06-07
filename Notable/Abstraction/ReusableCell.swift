//
//  ReusableCell.swift
//  Notable
//
//  Created by Khanh Dinh on 6/7/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

protocol ReusableCell {
    static var reuseIdentifier: String { get }
    static var reuseNibName: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var reuseNibName: String {
        return String(describing: self)
    }
}
