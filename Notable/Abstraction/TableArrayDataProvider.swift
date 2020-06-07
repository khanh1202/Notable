//
//  TableArrayDataProvider.swift
//  Notable
//
//  Created by Khanh Dinh on 6/7/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation

class TableDataArrayProvider<T>: TableDataProvider {
    private var items: [T]
    
    init(array: [T]) {
        items = array
    }
    
    func numberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.row >= 0 && indexPath.row < items.count else {
            return nil
        }
        
        return items[indexPath.row]
    }
}
