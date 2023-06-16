//
//  HomeRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit
import iTunesAPI

//MARK: - HomeRouterProtocol
protocol HomeRouterProtocol {
    static func createModule() -> UIViewController
    func navigateToDetailView(on view: HomeViewProtocol?, with music: Music)
}
//MARK: - HomeRouter
final class HomeRouter: HomeRouterProtocol {
    
    func navigateToDetailView(on view: HomeViewProtocol?, with music: Music) {
        
        if let sourceView = view as? UIViewController {
            let detailViewController = DetailRouter.createDetailModule()
            if let detailView = detailViewController as? DetailView {
                detailView.presenter?.music = music
            }
            sourceView.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    static func createModule() -> UIViewController {
        
        let view = HomeView()
        var presenter: HomePresenterProtocol & HomePresenterOutputProtocol = HomePresenter()
        var interactor: HomeInteractorProtocol = HomeInteractor(service: ITunesService())
        let router: HomeRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
