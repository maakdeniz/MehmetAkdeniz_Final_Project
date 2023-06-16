//
//  HomeInteractor.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import Foundation
import iTunesAPI

protocol HomeInteractorProtocol {
    var presenter:HomePresenterOutputProtocol? { get set }
    var service: ITunesServiceProtocol? { get set }
    func fetchMusicForArtist(searchTerm: String)
}

final class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterOutputProtocol?
    var service: ITunesServiceProtocol?
    
    init(service: ITunesServiceProtocol) {
        self.service = service
    }
    
    func fetchMusicForArtist(searchTerm:String) {
        service?.fetchMusicForArtist(artist: searchTerm) { [weak self] result in
            switch result {
            case .success(let musicList):
                self?.presenter?.musicFetchedSuccess(musicModelArray: musicList)
            case .failure(let error):
                print(error)
                self?.presenter?.musicFetchFailed()
            }
        }
    }
}
