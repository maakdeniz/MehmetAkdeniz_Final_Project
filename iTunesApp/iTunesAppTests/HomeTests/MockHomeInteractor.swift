//
//  MockHomeInteractor.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 9.06.2023.
//

import XCTest
@testable import iTunesApp // Projedeki gerçek module ismini kullanın.
@testable import iTunesAPI

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var presenter: HomePresenterOutputProtocol?
    var service: ITunesServiceProtocol?
    var isFetchMusicCalled = false

    func fetchMusicForArtist(searchTerm: String) {
        isFetchMusicCalled = true
    }
}
