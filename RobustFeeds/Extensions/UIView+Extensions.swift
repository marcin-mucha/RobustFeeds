//
//  UIView+Extensions.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import CoreGraphics

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
