//
//  HomePresenterTests.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 8.06.2023.
//



import XCTest
@testable import iTunesApp
@testable import iTunesAPI

final class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter!
    var interactor: MockHomeInteractor!
    var view: MockHomeView!
    var router: MockHomeRouter!
    
    let music = Music(artistName: "Test Artist", trackName: "Test Track",
                      artworkUrl: "Test Artwork Url", collectionName: "Test Collection",
                      previewUrl: "Test Preview Url", trackPrice: 1.0, collectionPrice: 1.0,
                      primaryGenreName: "Test Genre")
    
    override func setUp() {
        super.setUp()
        view = MockHomeView()
        interactor = MockHomeInteractor()
        router = MockHomeRouter()
        presenter = HomePresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
    }

    func testStartFetchingMusic() {
        presenter.startFetchingMusic(searchTerm: "Test")
        XCTAssertTrue(interactor.isFetchMusicCalled)
    }

    func testMusicFetchedSuccess() {
        presenter.musicFetchedSuccess(musicModelArray: [music])
        XCTAssertTrue(view.isShowMusicCalled)
    }

    func testMusicFetchFailed() {
        presenter.musicFetchFailed()
        XCTAssertTrue(view.isShowErrorCalled)
    }

    func testShowDetailScreen() {
        presenter.showDetailScreen(music: music)
        XCTAssertTrue(router.isNavigateToDetailViewCalled)
    }
}

