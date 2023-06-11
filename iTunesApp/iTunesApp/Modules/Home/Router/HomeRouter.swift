//
//  HomeRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit
import iTunesAPI

protocol PresenterToRouterHomeProtocol {
    static func createModule() -> UIViewController
    func navigateToDetailView(on view: PresenterToViewHomeProtocol?, with music: Music)
}

class HomeRouter: PresenterToRouterHomeProtocol {
    
    func navigateToDetailView(on view: PresenterToViewHomeProtocol?, with music: Music) {
        
        if let sourceView = view as? UIViewController {
            let detailViewController = DetailRouter.createDetailModule(with: music)
            if let detailView = detailViewController as? DetailView {
                detailView.presenter?.music = music
            }
            sourceView.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

    static func createModule() -> UIViewController {
        
        let view = HomeView(nibName: "HomeView", bundle: nil)  // Bu satır kodu ekleyin
        var presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        var interactor: PresenterToInteractorHomeProtocol = HomeInteractor()
        let router: PresenterToRouterHomeProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}


