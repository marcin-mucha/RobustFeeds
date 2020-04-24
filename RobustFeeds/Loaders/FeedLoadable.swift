//
//  Loadable.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

protocol FeedLoadable {
    func load() -> AnyPublisher<Feed, Error>
}

struct Feed {
    let title: String?
    let content: Content
    
    enum Content {
        case native([FeedItem])
        case web(URL)
    }
}

enum FeedItem {
    case articleTeaser(title: String)
    case ad(id: String)
    case widget(type: String)
}
