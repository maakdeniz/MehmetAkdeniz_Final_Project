//
//  MockItunesService.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 8.06.2023.
//

import XCTest
@testable import iTunesAPI
@testable import iTunesApp

final class MockITunesService: ITunesServiceProtocol {
    
    var fetchMusicResult: Result<[Music], Error>!
    
    func fetchMusicForArtist(artist: String, completion: @escaping (Result<[Music], Error>) -> Void) {
        completion(fetchMusicResult)
    }
}


