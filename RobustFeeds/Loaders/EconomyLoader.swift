//
//  EconimyLoader.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

struct EconomyPage: Decodable {
    let title: String
    let items: [Item]
}

extension EconomyPage {
    enum CodingKeys: CodingKey {
        case title
        case items
    }
    
    enum Item: Decodable {
        case teaser(title: String)
        case ad(id: String)
        case widget(subtype: String)
    }
}

extension EconomyPage.Item {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        switch try container.decode(String.self, forKey: .type) {
        case "teaser":
            self = .teaser(title: try container.decode(String.self, forKey: .title))
        case "ad":
            self = .ad(id: try container.decode(String.self, forKey: .id))
        case "widget":
            self = .widget(subtype: try container.decode(String.self, forKey: .subtype))
        default:
            fatalError("Unknown type")
        }
    }
    
    enum CodingKeys: CodingKey {
        case type
        case title
        case id
        case subtype
    }
}

struct EconomyLoader: FeedLoadable {
    private let jsonName: String
    
    init(jsonName: String) {
        self.jsonName = jsonName
    }
    
    func load() -> AnyPublisher<Feed, Error> {
        let future: Future<EconomyPage, Error> = WebService.load(jsonName: jsonName)
        return future.map { page in
            let feedItems = page.items.map(\.asFeedItem)
            return Feed(title: page.title, content: .native(feedItems))
        }
        .eraseToAnyPublisher()
    }
}

extension EconomyPage.Item {
    var asFeedItem: FeedItem {
        switch self {
        case .teaser(let title):
            return .articleTeaser(title: title)
        case .ad(let id):
            return .ad(id: id)
        case .widget(let subtype):
            return .widget(type: subtype)
        }
    }
}
