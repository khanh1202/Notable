//
//  Spinner.swift
//  Notable
//
//  Created by Khanh Dinh on 6/1/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//
import UIKit

class Spinner {
    static var spinner: UIActivityIndicatorView?
    
    static func start(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.medium, backColor: UIColor = UIColor(white: 0, alpha: 0.6), baseColor: UIColor = UIColor.white) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    @objc static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
