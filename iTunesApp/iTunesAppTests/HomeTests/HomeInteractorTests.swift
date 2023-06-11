//
//  HomeInteractorTests.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 8.06.2023.
//

import XCTest
@testable import iTunesApp
@testable import iTunesAPI

final class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor!
    var mockPresenter: MockHomePresenterOutputProtocol!
    var mockService: MockITunesService!

    override func setUp() {
        super.setUp()

        mockPresenter = MockHomePresenterOutputProtocol()
        mockService = MockITunesService()
        sut = HomeInteractor(service: mockService)
        sut.presenter = mockPresenter
    }

    override func tearDown() {
        sut = nil
        mockPresenter = nil
        mockService = nil

        super.tearDown()
    }

    func testFetchMusicForArtistSuccess() {

        let expectedMusicArray = [Music(artistName: "TestArtist",
                                         trackName: "TestTrack",
                                         artworkUrl: "TestUrl",
                                         collectionName: "TestCollection",
                                         previewUrl: "TestPreviewUrl",
                                         trackPrice: 1.99,
                                         collectionPrice: 9.99,
                                         primaryGenreName: "TestGenre")]
        mockService.fetchMusicResult = .success(expectedMusicArray)
        sut.fetchMusicForArtist(searchTerm: "Test")
        XCTAssertEqual(mockPresenter.musicModelArray, expectedMusicArray, "The fetched music array is not correct")
    }

    func testFetchMusicForArtistFailure() {
        mockService.fetchMusicResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        sut.fetchMusicForArtist(searchTerm: "Test")

        XCTAssertTrue(mockPresenter.isFetchFailed)
    }
}

