//
//  File.swift
//  iTunesClassApp
//
//  Created by Israrul on 4/7/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var resultCount: Int?
    var results: [Artist]?
}
