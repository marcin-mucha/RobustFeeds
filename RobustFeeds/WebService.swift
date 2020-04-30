//
//  WebService.swift
//  RobustFeeds
//
//  Created by Marcin Mucha on 27/03/2020.
//  Copyright © 2020 STP. All rights reserved.
//

import Foundation
import Combine

class WebService {
    static func load<T: Decodable>(jsonName: String) -> Future<T, Error> {
        return Future { completion in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                do {
                    let data = try Data(jsonNamed: jsonName)
                    let page = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(page))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
