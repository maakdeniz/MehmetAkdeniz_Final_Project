//
//  DetailPresenter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//
import Foundation
import iTunesAPI
//MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? { get set }
    var router: DetailRoterProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var music: Music? { get set }
    
    func startSetup()
    func addToFavorites(music: Music)
    func removeFromFavorites(music: Music)
    func checkIfFavorite(music: Music)
    func handleFavoriteTap(for music: Music)
    func playOrStopMusic()
    func confirmAddToFavorites(for music: Music)
    func confirmRemoveFromFavorites(for music: Music)
    func checkIfFavoriteOnInit(for music: Music)
}
//MARK: - DetailPresenter
final class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol?
    var router: DetailRoterProtocol?
    var interactor: DetailInteractorProtocol?
    
    var music: Music? {
        didSet {
            (view as? DetailView)?.music = music
        }
    }
    
    func startSetup() {
        print("Setting up DetailPresenter")
        if music != nil {
            view?.showMusicDetail()
        } else {
            view?.showError()
        }
    }
    
    func addToFavorites(music: Music) {
        interactor?.addToFavorites(music: music)
        view?.showAddedToFavorites()
    }
    
    func removeFromFavorites(music: Music) {
        interactor?.removeFromFavorites(music: music)
        view?.showRemovedFromFavorites()
    }
    
    func checkIfFavorite(music: Music) {
        let isFavorite = interactor?.isFavorite(music: music) ?? false
        view?.updateFavoriteStatus(isFavorite: isFavorite, withAnimation: false)
    }
    
    func playOrStopMusic() {
        interactor?.playOrStopMusic(for: music!)
        view?.updatePlayButton(isPlaying: (MusicPlayerService.shared.player?.rate != 0))
    }
    
    func handleFavoriteTap(for music: Music) {
        if CoreDataStack.shared.isFavorite(music: music) {
            view?.presentRemoveConfirmation()
        } else {
            view?.presentAddConfirmation()
        }
    }
    
    func confirmAddToFavorites(for music: Music) {
        addToFavorites(music: music)
    }
    
    func confirmRemoveFromFavorites(for music: Music) {
        removeFromFavorites(music: music)
    }
    
    func checkIfFavoriteOnInit(for music: Music) {
        let isFavorite = CoreDataStack.shared.isFavorite(music: music)
        view?.updateFavoriteStatus(isFavorite: isFavorite, withAnimation: false)
    }
}

