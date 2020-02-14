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
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove() {
        if parent != nil {
            willMove(toParent: nil)
            removeFromParent()
        }
        view.removeFromSuperview()
    }
}
