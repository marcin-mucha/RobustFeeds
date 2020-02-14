//
//  Loadable.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

protocol Loadable {
    func load() -> Future<Feed, Error>
}

struct Feed {
    let title: String
    let content: Content
    
    enum Content {
        case native([FeedItem])
        case web(URL)
    }
}

enum FeedItem {
    case articleTeaser
    case ad
    case widget
}
