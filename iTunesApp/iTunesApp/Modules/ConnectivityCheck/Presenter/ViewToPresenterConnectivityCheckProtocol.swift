//
//  ViewToPresenterConnectivityCheckProtocol.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit

protocol ViewToPresenterConnectivityCheckProtocol: AnyObject {
    var view: PresenterToViewConnectivityCheckProtocol? { get set }
    var interactor: PresenterToInteractorConnectivityCheckProtocol? { get set }
    var router: PresenterToRouterConnectivityCheckProtocol? { get set }
    
    func startCheckingInternetConnection()
}

protocol InteractorToPresenterConnectivityCheckProtocol: AnyObject {
    func internetConnectionSuccess()
    func internetConnectionFailed()
}

class ConnectivityCheckPresenter: ViewToPresenterConnectivityCheckProtocol {
    weak var view: PresenterToViewConnectivityCheckProtocol?
    var interactor: PresenterToInteractorConnectivityCheckProtocol?
    var router: PresenterToRouterConnectivityCheckProtocol?
    
    func startCheckingInternetConnection() {
        view?.showLoading()
        interactor?.checkInternetConnection()
    }
}

extension ConnectivityCheckPresenter: InteractorToPresenterConnectivityCheckProtocol {
    func internetConnectionSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.router?.pushToHomeScreen()
        }
    }
    
    func internetConnectionFailed() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.showError()
        }
    }
}

