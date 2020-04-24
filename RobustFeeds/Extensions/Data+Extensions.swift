//
//  Data+Extensions.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 27/03/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation

private enum Error: Swift.Error {
    case missingFile
}

public extension Data {
    init(jsonNamed name: String, bundleName: String = "JSON") throws {
        guard let jsonBundleUrl = Bundle.main.url(forResource: bundleName, withExtension: "bundle"),
              let jsonBundle = Bundle(url: jsonBundleUrl),
              let url = jsonBundle.url(forResource: name, withExtension: "json") else {
                throw Error.missingFile
              }
        try self.init(contentsOf: url)
    }
}
