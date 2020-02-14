//
//  NativeFeedViewController.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 14/02/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import UIKit

class NativeFeedViewController: UITableViewController {
    private let feedItems: [FeedItem]
    
    init(title: String, feedItems: [FeedItem]) {
        self.feedItems = feedItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(FeedCell.self, forCellReuseIdentifier: "Feed")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Feed", for: indexPath) as? FeedCell else { fatalError("Incorrect cell type.")
        }
        
        cell.configure(with: feedItems[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch feedItems[indexPath.row] {
        case .articleTeaser:
            return 88
        case .ad:
            return 120
        case .widget:
            return 140
        }
    }
}

class FeedCell: UITableViewCell {
    private let titleLabel = UILabel()
    
    func configure(with item: FeedItem) {
        let title: String
        let color: UIColor
        switch item {
        case .articleTeaser:
            title = "This is an article teaser."
            color = .white
        case .ad:
            title = "ADVERTISMENT"
            color = .yellow
        case .widget:
            title = "WIDGET"
            color = .cyan
        }
        titleLabel.text = title
        contentView.backgroundColor = color
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
