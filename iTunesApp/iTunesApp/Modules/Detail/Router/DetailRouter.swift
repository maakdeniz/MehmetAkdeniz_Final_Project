//
//  DetailRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//


//import iTunesAPI
import UIKit

protocol DetailRoterProtocol {
    static func createDetailModule(/*with music: Music*/) -> UIViewController
}

final class DetailRouter: DetailRoterProtocol {
    static func createDetailModule(/*with music: Music*/) -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: nil)
        let interactor: DetailInteractorProtocol = DetailInteractor()
        var presenter: DetailPresenterProtocol = DetailPresenter()
        
        view.presenter = presenter
        presenter.view = view as DetailViewProtocol
        //presenter.music = music
        presenter.interactor = interactor
        //interactor.music = music
        
        return view
    }
}

