//
//  ConfigurableCell.swift
//  Notable
//
//  Created by Khanh Dinh on 6/7/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation

protocol ConfigurableCell: ReusableCell {
    associatedtype T
    
    func configure(_ item: T?, at indexPath: IndexPath)
}
