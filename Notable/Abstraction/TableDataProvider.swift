//
//  TableDataProvider.swift
//  Notable
//
//  Created by Khanh Dinh on 6/7/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//
import Foundation

protocol TableDataProvider {
    associatedtype T
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
}

extension TableDataProvider {
    func numberOfSections() -> Int {
        return 1
    }
}
