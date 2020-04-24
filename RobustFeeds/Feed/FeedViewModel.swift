//
//  FeedViewModel.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

protocol FeedViewModelType {
    func load()
    var state: CurrentValueSubject<FeedViewModel.State, Never> { get }
}

final class FeedViewModel: FeedViewModelType {
    enum State {
        case loading
        case error(Error)
        case feed(Feed)
    }
    
    let state: CurrentValueSubject<State, Never> = .init(.loading)
    
    private let loader: FeedLoadable
    private var subscriptions: Set<AnyCancellable> = []
    
    init(loader: FeedLoadable) {
        self.loader = loader
    }
    
    func load() {
        state.value = .loading
        loader.load()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state.send(.error(error))
                case .finished: break
                }
                }, receiveValue: { [weak self] feed in
                    self?.state.send(.feed(feed))
            })
            .store(in: &subscriptions)
    }
}
