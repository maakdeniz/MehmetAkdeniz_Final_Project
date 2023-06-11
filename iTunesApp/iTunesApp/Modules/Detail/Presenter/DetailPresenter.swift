//
//  DetailPresenter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//

import Foundation
import iTunesAPI

protocol ViewToPresenterDetailProtocol {
    var view: PresenterToViewDetailProtocol? { get set }
    var router: PresenterToRouterDetailProtocol? { get set }
    var music: Music? { get set }
    
    func startSetup()
}

class DetailPresenter: ViewToPresenterDetailProtocol {
    var view: PresenterToViewDetailProtocol?
    var router: PresenterToRouterDetailProtocol?
    var music: Music? {
            didSet {
                (view as? DetailView)?.music = music
            }
        }
    
    func startSetup() {
        print("Setting up DetailPresenter")
        if let music = music {
            view?.showMusicDetail()
        } else {
            view?.showError()
        }
    }
}

