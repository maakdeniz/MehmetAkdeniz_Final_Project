//
//  MockDetailInteractorTests.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 9.06.2023.
//

import XCTest
@testable import iTunesApp
@testable import iTunesAPI

final class MockDetailInteractor: DetailInteractorProtocol {
    
    var music: Music?
    var isAddToFavoritesCalled = false
    var isRemoveFromFavoritesCalled = false
    var isFavoriteCalled = false
    var isPlayOrStopMusicCalled = false
    
    func addToFavorites(music: Music) {
        isAddToFavoritesCalled = true
    }
    
    func removeFromFavorites(music: Music) {
        isRemoveFromFavoritesCalled = true
    }
    
    func isFavorite(music: Music) -> Bool {
        isFavoriteCalled = true
        return false
    }
    
    func playOrStopMusic(for music: Music) {
        isPlayOrStopMusicCalled = true
    }
}
