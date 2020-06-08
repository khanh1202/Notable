//
//  StoryboardRedirect.swift
//  Notable
//
//  Created by Khanh Dinh on 6/8/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import UIKit

extension UIViewController {
    func redirectTo(storyboard: String, bundle: Bundle?) {
        let storyBoard = UIStoryboard(name: storyboard, bundle: bundle)
        
        if let initialialVC = storyBoard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialialVC
            self.view.window?.makeKeyAndVisible()
        }
    }
}
