//
//  HomeViewController.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 24/04/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewController: UITableViewController {
    private let items = Item.allCases
 
    enum Item: String, CaseIterable {
        case economy = "Economy section"
        case lifestyle = "Lifestyle section"
        case web = "Sport section"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        title = "Robust Feeds"
        
        tableView.rowHeight = 88
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        showSection(for: item)
    }
    
    private func showSection(for item: Item) {
        let loader: FeedLoadable
        switch item {
        case .economy:
            loader = EconomyLoader(jsonName: "Economy")
        case .lifestyle:
            loader = LifestyleLoader(jsonName: "Lifestyle") { pageItems in
                var newPageItems = pageItems
                newPageItems.insert(.ad(id: "457"), at: 4)
                newPageItems.insert(.widget(type: "carousel"), at: 10)
                return newPageItems
            }
        case .web:
            loader = WebLoader(url: URL(string: "https://www.vg.no/sport/")!, title: "VG Sport")
        }
        let viewModel = FeedViewModel(loader: loader)
        let viewController = FeedViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
