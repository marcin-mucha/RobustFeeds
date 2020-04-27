//
//  LifestyleLoader.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 29/03/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

struct LifestylePage: Decodable {
    let title: String
    let items: [Item]
    
    let renderAsWeb: Bool //= Bool.random()
    let renderAsWebUrl: URL?
    
    struct Item: Decodable {
        let title: String
    }
}

struct LifestyleLoader: FeedLoadable {
    let jsonName: String
    let transform: ([FeedItem]) -> [FeedItem]
    
    func load() -> AnyPublisher<Feed, Error> {
        let future: Future<LifestylePage, Error> = WebService.load(jsonName: jsonName)
        return future.map { [transform] page in
            if page.renderAsWeb, let renderAsWebUrl = page.renderAsWebUrl {
                return Feed(title: page.title, content: .web(renderAsWebUrl))
            } else {
                let feedItems = page.items.map(\.asFeedItem)
                let transformedFeedItems = transform(feedItems)
                return Feed(title: page.title, content: .native(transformedFeedItems))
            }
        }
        .eraseToAnyPublisher()
    }
}

private extension LifestylePage.Item {
    var asFeedItem: FeedItem {
        return .articleTeaser(title: title)
    }
}
