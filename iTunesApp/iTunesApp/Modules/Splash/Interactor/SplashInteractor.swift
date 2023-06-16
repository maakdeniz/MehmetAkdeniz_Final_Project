//
//  SplashInteractor.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 16.06.2023.
//

import Foundation

protocol SplashInteractorProtocol {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol {
    func internetConnectionStatus(_ status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internetStatus = Reachability.isConnectedToNetwork()
        self.output?.internetConnectionStatus(internetStatus)
    }
    
}
