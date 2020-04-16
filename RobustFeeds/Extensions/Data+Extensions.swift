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

extension Data {
    init(jsonNamed name: String) throws {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            throw Error.missingFile
        }
        try self.init(contentsOf: url)
    }
}
