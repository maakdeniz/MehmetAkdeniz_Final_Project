//
//  DetailPresenterTests.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 9.06.2023.
//

import XCTest
@testable import iTunesApp
@testable import iTunesAPI

final class DetailPresenterTests: XCTestCase {
    
    var presenter: DetailPresenter!
    var interactor: MockDetailInteractor!
    var view: MockDetailView!
    
    let music = Music(artistName: "Test Artist", trackName: "Test Track",
                      artworkUrl: "Test Artwork Url", collectionName: "Test Collection",
                      previewUrl: "Test Preview Url", trackPrice: 1.0, collectionPrice: 1.0,
                      primaryGenreName: "Test Genre")
    
    override func setUp() {
        super.setUp()
        view = MockDetailView()
        interactor = MockDetailInteractor()
        presenter = DetailPresenter()
        presenter.view = view
        presenter.interactor = interactor
    }
    
    func testStartSetup() {
        presenter.startSetup()
        XCTAssertTrue(view.isShowErrorCalled || view.isShowMusicDetailCalled)
    }
    
    func testAddToFavorites() {
        
        presenter.addToFavorites(music: music)
        XCTAssertTrue(interactor.isAddToFavoritesCalled)
        XCTAssertTrue(view.isShowAddedToFavoritesCalled)
    }
    
    func testRemoveFromFavorites() {
       
        presenter.removeFromFavorites(music: music)
        XCTAssertTrue(interactor.isRemoveFromFavoritesCalled)
        XCTAssertTrue(view.isShowRemovedFromFavoritesCalled)
    }

    func testHandleFavoriteTap() {
        
        presenter.handleFavoriteTap(for: music)
        XCTAssertTrue(view.isPresentAddConfirmationCalled || view.isPresentRemoveConfirmation)
    }
    
    func testConfirmAddToFavorites() {
        
        presenter.confirmAddToFavorites(for: music)
        XCTAssertTrue(interactor.isAddToFavoritesCalled)
        XCTAssertTrue(view.isShowAddedToFavoritesCalled)
    }
    
    func testConfirmRemoveFromFavorites() {
        
        presenter.confirmRemoveFromFavorites(for: music)
        XCTAssertTrue(interactor.isRemoveFromFavoritesCalled)
        XCTAssertTrue(view.isShowRemovedFromFavoritesCalled)
    }
    
    func testCheckIfFavorite() {
        
        presenter.checkIfFavorite(music: music)
        XCTAssertTrue(interactor.isFavoriteCalled)
        XCTAssertTrue(view.isUpdateFavoriteStatusCalled)
        
    }
    
    func testCheckIfFavoriteOnInit() {
        
        presenter.checkIfFavoriteOnInit(for: music)
        XCTAssertTrue(view.isUpdateFavoriteStatusCalled)
        
    }
    
}
