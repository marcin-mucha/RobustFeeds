//
//  ErrorViewController.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    private let messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(messageLabel)
        view.backgroundColor = .red
        messageLabel.text = "An error has occurred."
        messageLabel.textColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        messageLabel.center = view.bounds.center
    }
}
