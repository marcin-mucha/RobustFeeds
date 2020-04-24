//
//  ViewController.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import UIKit
import Combine

final class FeedViewController: UIViewController {
    private let viewModel: FeedViewModelType
    private var subscriptions: Set<AnyCancellable> = []
    private var currentViewController: UIViewController? {
        didSet {
            updateChildren(add: currentViewController, remove: oldValue)
        }
    }
    
    init(viewModel: FeedViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.configure(with: state)
            }
            .store(in: &subscriptions)
        
        viewModel.load()
    }
    
    private func configure(with state: FeedViewModel.State) {
        switch state {
        case .loading:
            currentViewController = LoadingViewController()
        case .error(let error):
            currentViewController = ErrorViewController(errorMessage: error.localizedDescription)
        case .feed(let feed):
            switch feed.content {
            case .native(let items):
                currentViewController = NativeFeedViewController(title: feed.title, feedItems: items)
            case .web(let url):
                currentViewController = WebFeedViewController(url: url, title: feed.title)
            }
        }
    }
    
    private func updateChildren(add viewController: UIViewController?, remove oldViewController: UIViewController?) {
        guard viewController != oldViewController else { return }

        oldViewController?.remove()

        guard let viewController = viewController else { return }

        add(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
