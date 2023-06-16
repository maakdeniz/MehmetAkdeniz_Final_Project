//
//  HomePresenter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import Foundation
import iTunesAPI
//MARK: - HomePresenterOutputProtocol
protocol HomePresenterOutputProtocol {
    
    func musicFetchedSuccess(musicModelArray:Array<Music>)
    func musicFetchFailed()
    
}
//MARK: -HomePresenterProtocol
protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func startFetchingMusic(searchTerm: String)
    func showDetailScreen(music: Music)
    func setScreenTitle()
    func setSetupTableviewAndSearchBar()
}
//MARK: -HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func startFetchingMusic(searchTerm: String) {
        interactor?.fetchMusicForArtist(searchTerm: searchTerm)
    }
    
    func showDetailScreen(music: Music) {
        MusicPlayerService.shared.stop()
        router?.navigateToDetailView(on: view, with: music)
    }
    
    func setScreenTitle() {
        view?.setTitle("iTunes Search")
    }
    
    func setSetupTableviewAndSearchBar() {
        view?.setupTableviewAndSearchBar()
    }
}
//MARK: - HomePresenterOutputProtocol Extesion
extension HomePresenter: HomePresenterOutputProtocol {
    
    func musicFetchedSuccess(musicModelArray: Array<Music>) {
        view?.showMusic(musicArray: musicModelArray)
    }
    
    func musicFetchFailed() {
        view?.showError()
    }
}
