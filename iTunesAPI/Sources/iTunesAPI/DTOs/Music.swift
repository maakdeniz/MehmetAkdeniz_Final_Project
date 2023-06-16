//
//  Music.swift
//
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//


public struct Music: Decodable,Equatable {
    
    public let artistName: String?
    public let trackName: String?
    public let artworkUrl: String?
    public let collectionName: String?
    public let previewUrl: String?
    public let trackPrice: Double?
    public let collectionPrice: Double?
    public let primaryGenreName: String?
    
}

struct MusicData: Codable {
    let results: [Track]
}

struct Track: Codable {
    let artistName: String?
    let trackName: String?
    let artworkUrl100: String?
    let collectionName: String?
    let previewUrl: String?
    let trackPrice: Double?
    let collectionPrice: Double?
    let primaryGenreName: String?
}

