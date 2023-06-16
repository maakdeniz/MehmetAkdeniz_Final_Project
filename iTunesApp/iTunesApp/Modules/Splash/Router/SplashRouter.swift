//
//  SplashRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 16.06.2023.
//

import Foundation
import UIKit

enum SplashRoutes {
    case homeScreen
}

protocol SplashRouterProtocol {
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter {
    
    weak var viewController: SplashView?
    
    static func createModule() -> SplashView {
        let view = SplashView()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    
    func navigate(_ route: SplashRoutes) {
        
        switch route {
        case .homeScreen:
            guard let window = viewController?.view.window else { return }
            let homeVC = HomeRouter.createModule()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window.makeKeyAndVisible()
            window.rootViewController = navigationController
        }
    }
    
}
