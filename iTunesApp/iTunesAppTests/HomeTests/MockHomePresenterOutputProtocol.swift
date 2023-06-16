//
//  MockHomePresenterOutputProtocol.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 11.06.2023.
//
import XCTest
@testable import iTunesAPI
@testable import iTunesApp

final class MockHomePresenterOutputProtocol: HomePresenterOutputProtocol {
    
    var musicModelArray: [Music] = []
    var isFetchFailed: Bool = false
    
    func musicFetchedSuccess(musicModelArray: [Music]) {
        self.musicModelArray = musicModelArray
    }
    
    func musicFetchFailed() {
        isFetchFailed = true
    }
}
