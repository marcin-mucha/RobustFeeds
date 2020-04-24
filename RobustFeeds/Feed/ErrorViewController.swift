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
    
    init(errorMessage: String) {
        super.init(nibName: nil, bundle: nil)
        messageLabel.text = "An error has occurred. \n \(errorMessage)"
        messageLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(messageLabel)
        view.backgroundColor = .red
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
