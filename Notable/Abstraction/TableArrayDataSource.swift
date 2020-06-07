//
//  TableArrayDataSource.swift
//  Notable
//
//  Created by Khanh Dinh on 6/7/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class TableArrayDataSource<T, Cell: UITableViewCell>: TableDataSource<TableDataArrayProvider<T>, Cell> where Cell: ConfigurableCell, Cell.T == T {
    var selectedItem: T? {
        if let selectedIndexpath = tableView.indexPathForSelectedRow {
            return item(at: selectedIndexpath)
        }
        
        return nil
    }
    
    init(tableView: UITableView, items: [T]) {
        let provider = TableDataArrayProvider(array: items)
        super.init(tableView: tableView, provider: provider)
    }
    
    func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
}
