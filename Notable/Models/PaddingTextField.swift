//
//  PaddingTextField.swift
//  Notable
//
//  Created by Khanh Dinh on 5/25/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    
    let padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 5
        layer.borderWidth = K.borderWidth
        layer.borderColor = K.borderColor
    }

}
