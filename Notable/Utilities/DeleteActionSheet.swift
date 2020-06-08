//
//  DeleteActionSheet.swift
//  Notable
//
//  Created by Khanh Dinh on 6/8/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDeleteActionSheet(shortMessage: String, longMessage: String, completion: @escaping (() -> ())) {
        let deleteAlert = UIAlertController(title: shortMessage, message: longMessage, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: K.Options.delete, style: .destructive) { (action) in
            completion()
        }
        let cancelAction = UIAlertAction(title: K.Options.cancel, style: .cancel, handler: nil)
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        present(deleteAlert, animated: true, completion: nil)
    }
}
