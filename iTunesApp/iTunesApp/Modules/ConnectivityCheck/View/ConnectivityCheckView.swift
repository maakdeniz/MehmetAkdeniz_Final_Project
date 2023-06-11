//
//  ViewController.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit

protocol PresenterToViewConnectivityCheckProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError()
}

class ConnectivityCheckView: UIViewController, LoadingShowable {

    var presenter: ViewToPresenterConnectivityCheckProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        presenter?.startCheckingInternetConnection()
    }
}

extension ConnectivityCheckView: PresenterToViewConnectivityCheckProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            LoadingView.shared.startLoading()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            LoadingView.shared.stopLoading()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: "No internet connection",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK",
                                         style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
}


