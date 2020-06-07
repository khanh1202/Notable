//
//  TableDataSource.swift
//  Notable
//
//  Created by Khanh Dinh on 6/7/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class TableDataSource<Provider: TableDataProvider, Cell: UITableViewCell>:
    NSObject,
    UITableViewDataSource where Cell: ConfigurableCell, Provider.T == Cell.T {
    let provider: Provider
    let tableView: UITableView
    
    init(tableView: UITableView, provider: Provider) {
        self.tableView = tableView
        self.provider = provider
        super.init()
        tableView.dataSource = self
        tableView.register(UINib(nibName: Cell.reuseNibName, bundle: nil), forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        let item = provider.item(at: indexPath)
        if let item = item {
            cell.configure(item, at: indexPath)
        }
        return cell
    }
}

