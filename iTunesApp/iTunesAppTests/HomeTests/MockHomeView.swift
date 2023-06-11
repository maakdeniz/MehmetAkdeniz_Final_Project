//
//  MockHomeView.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 9.06.2023.
//

import XCTest
@testable import iTunesApp
@testable import iTunesAPI

final class MockHomeView: HomeViewProtocol {
    
    var isShowMusicCalled = false
    var isShowErrorCalled = false
    var isSetTitleCalled = false
    var isSetupTableviewAndSearchBarCalled = false
    
    func setTitle(_ title: String) {
        isSetTitleCalled = true
    }
    
    func setupTableviewAndSearchBar() {
        isSetupTableviewAndSearchBarCalled = true
    }
    
    func showMusic(musicArray: Array<Music>) {
        isShowMusicCalled = true
    }

    func showError() {
        isShowErrorCalled = true
    }
}

