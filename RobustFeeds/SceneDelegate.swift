 //
//  SceneDelegate.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window = window
        window.windowScene = windowScene
        
        let viewModel = FeedViewModel(loader:
            EconomyLoader(jsonName: "EconomyJSON")
        )
        let viewController = FeedViewController(viewModel: viewModel)
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}

