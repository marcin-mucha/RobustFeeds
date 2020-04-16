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
    let teasers: [Teaser]
    
    let renderAsWeb: Bool
    let renderAsWebUrl: URL?
    
    struct Teaser: Decodable {
        let title: String
    }
}

struct LifestyleLoader: FeedLoadable {
    private let jsonName: String
    private let transform: ([FeedItem]) -> [FeedItem]
    
    func load() -> AnyPublisher<Feed, Error> {
        let future: Future<LifestylePage, Error> = WebService.load(jsonName: jsonName)
        return future.map { [transform] page in
            if page.renderAsWeb, let renderAsWebUrl = page.renderAsWebUrl {
                return Feed(title: page.title, content: .web(renderAsWebUrl))
            } else {
                let feedItems = page.teasers.map(\.asFeedItem)
                let transformedFeedItems = transform(feedItems)
                return Feed(title: page.title, content: .native(transformedFeedItems))
            }
        }
        .eraseToAnyPublisher()
    }
}

private extension LifestylePage.Teaser {
    var asFeedItem: FeedItem {
        return .articleTeaser(title: title)
    }
}
