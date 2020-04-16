//
//  UIViewController+Extensions.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child) // 1
        view.addSubview(child.view) // 2
        child.didMove(toParent: self) // 3
    }
    func remove() {
        if parent != nil {
            willMove(toParent: nil) // 1
            removeFromParent() // 2
        }
        view.removeFromSuperview() // 3
    }
}
