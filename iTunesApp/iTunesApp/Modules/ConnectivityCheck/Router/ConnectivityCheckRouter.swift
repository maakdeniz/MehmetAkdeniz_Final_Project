//
//  ConnectivityCheckRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//


import UIKit

import UIKit

protocol PresenterToRouterConnectivityCheckProtocol: AnyObject {
    static func createModule() -> UINavigationController?
    func pushToHomeScreen()
}

class ConnectivityCheckRouter: PresenterToRouterConnectivityCheckProtocol {
    weak var navigationController: UINavigationController?

    static func createModule() -> UINavigationController? {
        let view = ConnectivityCheckView()
        let presenter: ViewToPresenterConnectivityCheckProtocol & InteractorToPresenterConnectivityCheckProtocol = ConnectivityCheckPresenter()
        let interactor: PresenterToInteractorConnectivityCheckProtocol = ConnectivityCheckInteractor()
        let router = ConnectivityCheckRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        let navigationController = UINavigationController(rootViewController: view)
        router.navigationController = navigationController

        return navigationController
    }
    
    func pushToHomeScreen() {
        DispatchQueue.main.async { [weak self] in
            let homeViewController = HomeRouter.createModule()
            self?.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}




