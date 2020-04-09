//
//  Album.swift
//  iTunesClassApp
//
//  Created by Israrul on 4/7/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import Foundation


enum AlbumArtworkState {
    case placeholder
    case downloaded
    case failed
}

struct Artist: Codable {
    var artistId: Int?
    var kind: String?
    var artistName: String?
    var primaryGenreName: String?
    var artworkUrl100: String?
    var trackViewUrl: String?
    var previewUrl: String?
    var trackName: String?
}

