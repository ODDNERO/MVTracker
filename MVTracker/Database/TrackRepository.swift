//
//  TrackRepository.swift
//  MVTracker
//
//  Created by NERO on 8/11/24.
//

import Foundation
import RealmSwift
import UIKit

final class TrackRepository {
    private let realm = try! Realm()
    private var tracks: Results<Track>
    
    init() {
        print(realm.configuration.fileURL)
        tracks = realm.objects(Track.self)
    }
    
    //CREATE
    func saveTrack(_ data: MusicInfo) {
        let track = Track(trackId: data.trackId,
                          trackName: data.trackName, artistName: data.artistName,
                          trackTimeMillis: data.trackTimeMillis, previewUrl: data.previewUrl)
        do {
            try realm.write { realm.add(track) }
        } catch {
            print("Save Error: \(error)")
        }
    }
    
    //READ
    func fetchMyTracks() -> [Track] {
        return Array(tracks)
    }
    
    func isTrackFound(_ trackId: Int) -> Bool {
        return (tracks.filter { $0.trackId == trackId }.first) != nil
    }
    func fetchFoundTrack(_ trackId: Int) -> Track? {
        return (tracks.filter { $0.trackId == trackId }.first) ?? nil
    }
    
    //DELETE
    func deleteTrack(_ trackId: Int) {
        guard let track = fetchFoundTrack(trackId) else { return }
        do {
            try realm.write { realm.delete(track) }
        } catch {
            print("Delete Error: \(error)")
        }
    }
}
