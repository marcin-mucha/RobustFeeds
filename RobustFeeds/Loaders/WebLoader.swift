//
//  WebLoader.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 29/03/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

struct WebLoader: FeedLoadable {
    private let url: URL
    private let title: String?
    
    func load() -> AnyPublisher<Feed, Error> {
        return Result.Publisher(.success(Feed(title: title, content: .web(url))))
            .eraseToAnyPublisher()
    }
}
