//
//  Track.swift
//  MVTracker
//
//  Created by NERO on 8/11/24.
//

import Foundation
import RealmSwift

final class Track: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(primaryKey: true) var trackId: Int
    @Persisted var trackName: String
    @Persisted var artistName: String
    @Persisted var trackTimeMillis: Int
    @Persisted var previewUrl: String
    
    init(trackId: Int, trackName: String, artistName: String, trackTimeMillis: Int, previewUrl: String) {
        super.init()
        self.trackId = trackId
        self.trackName = trackName
        self.artistName = artistName
        self.trackTimeMillis = trackTimeMillis
        self.previewUrl = previewUrl
    }
//    convenience init(trackName: String, artistName: String, trackTimeMillis: Int, previewUrl: String) {
//        self.init()
//        self.trackName = trackName
//        self.artistName = artistName
//        self.trackTimeMillis = trackTimeMillis
//        self.previewUrl = previewUrl
//    }
}
