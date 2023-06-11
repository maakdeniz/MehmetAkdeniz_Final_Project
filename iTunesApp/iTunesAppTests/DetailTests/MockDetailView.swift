//
//  MockDetailPresenterTests.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 9.06.2023.
//

import XCTest
@testable import iTunesApp
@testable import iTunesAPI

final class MockDetailView: DetailViewProtocol {

    var music: Music?
    var isShowMusicDetailCalled = false
    var isPresentAddConfirmationCalled = false
    var isPresentRemoveConfirmation = false
    var isShowErrorCalled = false
    var isShowAddedToFavoritesCalled = false
    var isShowRemovedFromFavoritesCalled = false
    var isUpdateFavoriteStatusCalled = false
    var isUpdatePlayButtonCalled = false
    
    func showMusicDetail() {
        isShowMusicDetailCalled = true
    }
    
    func presentAddConfirmation() {
        isPresentAddConfirmationCalled = true
    }
    
    func presentRemoveConfirmation() {
        isPresentRemoveConfirmation = true
    }
    
    func showError() {
        isShowErrorCalled = true
    }
    
    func showAddedToFavorites() {
        isShowAddedToFavoritesCalled = true
    }
    
    func showRemovedFromFavorites() {
        isShowRemovedFromFavoritesCalled = true
    }
    
    func updateFavoriteStatus(isFavorite: Bool, withAnimation: Bool) {
        isUpdateFavoriteStatusCalled = true
    }
    
    func updatePlayButton(isPlaying: Bool) {
        isUpdatePlayButtonCalled = true
    }
}



