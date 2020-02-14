//
//  Loaders.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

struct AlphaLoader: Loadable {
    func load() -> Future<Feed, Error> {
        return Future { completion in
            let feedItems: [FeedItem] = [.articleTeaser, .articleTeaser, .ad, .articleTeaser, .widget, .ad, .articleTeaser]
            completion(.success(Feed(title: "Alpha", content: .native(feedItems))))
        }
    }
}

struct BravoLoader: Loadable {
    func load() -> Future<Feed, Error> {
        return Future { completion in
            let feedItems: [FeedItem] = [.articleTeaser, .articleTeaser, .ad, .articleTeaser, .widget, .ad, .articleTeaser]
            completion(.success(Feed(title: "Bravo", content: .native(feedItems))))
        }
    }
}

struct CharlieLoader: Loadable {
    func load() -> Future<Feed, Error> {
        return Future { completion in
            let feedItems: [FeedItem] = [.articleTeaser, .articleTeaser, .ad, .articleTeaser, .widget, .ad, .articleTeaser]
            completion(.success(Feed(title: "Charlie", content: .native(feedItems))))
        }
    }
}


