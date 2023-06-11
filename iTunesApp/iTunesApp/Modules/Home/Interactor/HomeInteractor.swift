//
//  HomeInteractor.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import Foundation
import iTunesAPI

protocol PresenterToInteractorHomeProtocol {
    var presenter:InteractorToPresenterHomeProtocol? { get set }
    func fetchMusicForArtist(searchTerm: String)
}

class HomeInteractor: PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol?
    let service = ITunesService()

    func fetchMusicForArtist(searchTerm: String) {
        service.fetchMusicForArtist(artist: searchTerm) { result in
            switch result {
            case .success(let musicList):
                self.presenter?.musicFetchedSuccess(musicModelArray: musicList)
            case .failure(_):
                self.presenter?.musicFetchFailed()
            }
        }
    }
}
