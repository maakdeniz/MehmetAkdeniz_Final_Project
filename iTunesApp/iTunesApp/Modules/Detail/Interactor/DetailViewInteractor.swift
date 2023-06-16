//
//  DetailInteractor.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 8.06.2023.
//

import Foundation
import iTunesAPI

//MARK: - DetailInteractorProtocol
protocol DetailInteractorProtocol {
    var music: Music? { get set }
    
    func addToFavorites(music: Music)
    func removeFromFavorites(music: Music)
    func isFavorite(music: Music) -> Bool
    func playOrStopMusic(for music: Music)
}

//MARK: - DetailInteractor
final class DetailInteractor: DetailInteractorProtocol {
    var music: Music?

    func addToFavorites(music: Music) {
        CoreDataStack.shared.addToFavorites(music: music)
    }
    
    func removeFromFavorites(music: Music) {
        CoreDataStack.shared.removeFromFavorites(music: music)
    }
    
    func isFavorite(music: Music) -> Bool {
        return CoreDataStack.shared.isFavorite(music: music)
    }
    
    func playOrStopMusic(for music: Music) {
        guard let musicUrl = URL(string: music.previewUrl ?? "") else {
                print("Music URL is nil.")
                return
        }

        if let playerRate = MusicPlayerService.shared.player?.rate, playerRate != 0 {
            MusicPlayerService.shared.pause()
        } else {
            MusicPlayerService.shared.play(url: musicUrl)
        }
    }
}
