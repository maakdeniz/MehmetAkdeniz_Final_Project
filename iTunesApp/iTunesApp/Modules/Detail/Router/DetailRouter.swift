//
//  DetailRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//

import UIKit
// MARK: - DetailRoterProtocol
protocol DetailRoterProtocol {
    static func createDetailModule() -> UIViewController
}
// MARK: - DetailRoter
final class DetailRouter: DetailRoterProtocol {
    static func createDetailModule() -> UIViewController {
        
        let view = DetailView(nibName: "DetailView", bundle: nil)
        let interactor: DetailInteractorProtocol = DetailInteractor()
        var presenter: DetailPresenterProtocol = DetailPresenter()
        
        view.presenter = presenter
        presenter.view = view as DetailViewProtocol
        presenter.interactor = interactor
        
        return view
    }
}

