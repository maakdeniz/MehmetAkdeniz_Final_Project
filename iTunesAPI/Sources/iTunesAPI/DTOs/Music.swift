//
//  Music.swift
//  
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//


import Foundation

public struct Music: Codable {
    public let artistName: String
    public let trackName: String
    public let artworkUrl: String
    public let collectionName: String
    public let previewUrl: String
    
    public init(artistName: String, trackName: String, artworkUrl: String, collectionName: String, previewUrl: String) {
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
        self.collectionName = collectionName
        self.previewUrl = previewUrl
    }
}

