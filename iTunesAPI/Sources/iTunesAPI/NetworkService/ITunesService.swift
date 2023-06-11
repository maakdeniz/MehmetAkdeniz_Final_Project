//
//  ITunesService.swift
//  
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import Foundation

public class ITunesService {
    public init() { }

    public func fetchMusicForArtist(artist: String, completion: @escaping (Result<[Music], Error>) -> Void) {
        guard let encodedArtist = artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                 let url = URL(string: "https://itunes.apple.com/search?term=\(encodedArtist)&media=music") else {
               print("Invalid URL")
               return
           }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let musicData = try decoder.decode(MusicData.self, from: data)

                let musicList = musicData.results.map { track in
                    Music(artistName: track.artistName,
                          trackName: track.trackName,
                          artworkUrl: track.artworkUrl100,
                          collectionName: track.collectionName,
                          previewUrl: track.previewUrl)
                }

                completion(.success(musicList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct MusicData: Codable {
    let results: [Track]
}

struct Track: Codable {
    let artistName: String
    let trackName: String
    let artworkUrl100: String
    let collectionName: String
    let previewUrl: String
}

