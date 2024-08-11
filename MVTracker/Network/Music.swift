//
//  Music.swift
//  MVTracker
//
//  Created by NERO on 8/8/24.
//

import Foundation

struct Music: Decodable {
    let resultCount: Int
    let results: [MusicInfo]
}

struct MusicInfo: Decodable {
    let artistId, trackId: Int
    let artistName, trackName: String
    let artistViewUrl, trackViewUrl: String
    let previewUrl: String //MV .m4v
    let artworkUrl100: String
    let releaseDate: String
    let trackTimeMillis: Int
    let primaryGenreName: String
}
