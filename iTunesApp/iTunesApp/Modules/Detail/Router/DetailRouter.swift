//
//  DetailRouter.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//

import Foundation
import iTunesAPI
import UIKit

protocol PresenterToRouterDetailProtocol {
    static func createDetailModule(with music: Music) -> UIViewController
}

class DetailRouter: PresenterToRouterDetailProtocol {
    static func createDetailModule(with music: Music) -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: nil)
        var presenter: ViewToPresenterDetailProtocol = DetailPresenter()
        
        view.presenter = presenter
        presenter.view = view as? any PresenterToViewDetailProtocol
        presenter.music = music
        
        return view
    }
}

