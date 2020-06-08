//
//  MultiSelectTable.swift
//  Notable
//
//  Created by Khanh Dinh on 6/8/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class MultiSelectTable<T: Equatable, Cell: UITableViewCell>: UIViewController, UITableViewDelegate where Cell: ConfigurableCell, Cell.T == T {
    var selectedItems: [T] = []
    var datasource: TableArrayDataSource<T, Cell>!
    var selectItemClosure: ((IndexPath) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = datasource.item(at: indexPath) else {
            return
        }
        
        if tableView.isEditing {
            selectedItems.append(selectedItem)
        } else {
            selectItemClosure?(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let deselectedItem = datasource.item(at: indexPath), let deselectedIndex = selectedItems.firstIndex(of: deselectedItem) else {
            return
        }
        
        selectedItems.remove(at: deselectedIndex)
    }
}

