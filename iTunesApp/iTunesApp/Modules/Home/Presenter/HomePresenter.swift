//
//  HomePresenter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import Foundation
import iTunesAPI

protocol InteractorToPresenterHomeProtocol {
    func musicFetchedSuccess(musicModelArray:Array<Music>)
    func musicFetchFailed()
}

protocol ViewToPresenterHomeProtocol {
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    
    func startFetchingMusic(searchTerm: String)
    func showDetailScreen(music: Music)
}

class HomePresenter: ViewToPresenterHomeProtocol {
    
    func showDetailScreen(music: Music) {
        router?.navigateToDetailView(on: view, with: music)
    }
    
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    func startFetchingMusic(searchTerm: String) {
        interactor?.fetchMusicForArtist(searchTerm: searchTerm)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func musicFetchedSuccess(musicModelArray: Array<Music>) {
        view?.showMusic(musicArray: musicModelArray)
    }
    
    func musicFetchFailed() {
        view?.showError()
    }
}


